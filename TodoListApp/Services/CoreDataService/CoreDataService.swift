//
//  CoreDataService.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import CoreData

actor CoreDataService: StorageServiceProtocol {

    // MARK: - Properties

    private let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext

    // MARK: - Initialization

    init() {
        let container = NSPersistentContainer(name: "TodoListApp")
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        self.persistentContainer = container
        let bgContext = container.newBackgroundContext()
        bgContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        self.backgroundContext = bgContext
    }

    // MARK: - Public Methods
    
    func fetchTodos() async throws -> [TodoTask] {
        try await backgroundContext.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            let taskEntities = try self.backgroundContext.fetch(fetchRequest)
            return taskEntities.map { $0.toTodoTask() }
        }
    }

    func fetchTodoById(id: UUID) async throws -> TodoTask? {
        try await backgroundContext.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            fetchRequest.fetchLimit = 1

            guard let entity = try self.backgroundContext.fetch(fetchRequest).first else {
                return nil
            }
            return entity.toTodoTask()
        }
    }

    func saveTodo(todoTask: TodoTask) async throws {
        try await backgroundContext.perform {
            let taskEntity = TaskEntity(context: self.backgroundContext)
            taskEntity.id = todoTask.id
            taskEntity.title = todoTask.title
            taskEntity.taskDescription = todoTask.description
            taskEntity.isCompleted = todoTask.isCompleted
            taskEntity.createdAt = todoTask.createdAt
            try self.backgroundContext.save()
        }
    }

    func saveTodos(todoTasks: [TodoTask]) async throws {
        try await backgroundContext.perform {
            todoTasks.forEach { todoTask in
                let taskEntity = TaskEntity(context: self.backgroundContext)
                taskEntity.id = todoTask.id
                taskEntity.title = todoTask.title
                taskEntity.taskDescription = todoTask.description
                taskEntity.isCompleted = todoTask.isCompleted
                taskEntity.createdAt = todoTask.createdAt
            }
            try self.backgroundContext.save()
        }
    }

    func updateTodo(todoTask: TodoTask) async throws {
        try await backgroundContext.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", todoTask.id as CVarArg)
            if let taskEntity = try self.backgroundContext.fetch(fetchRequest).first {
                taskEntity.title = todoTask.title
                taskEntity.taskDescription = todoTask.description
                taskEntity.isCompleted = todoTask.isCompleted
            }
            try self.backgroundContext.save()
        }
    }

    func deleteTodo(id: UUID) async throws {
        try await backgroundContext.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            if let taskEntity = try self.backgroundContext.fetch(fetchRequest).first {
                self.backgroundContext.delete(taskEntity)
            }
            try self.backgroundContext.save()
        }
    }
}
