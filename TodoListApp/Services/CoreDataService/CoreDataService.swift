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

    // MARK: - Initialization

    init() {
        persistentContainer = NSPersistentContainer(name: "TodoListApp")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    // MARK: - Public Methods
    
    func fetchTodoTasks() async throws -> [TodoTask] {
        let context = persistentContainer.newBackgroundContext()
        return try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            let taskEntities = try context.fetch(fetchRequest)
            return taskEntities.map { $0.mapToTodoTask() }
        }
    }

    func fetchTodoTaskById(id: UUID) async throws -> TodoTask? {
        let context = persistentContainer.newBackgroundContext()
        return try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            fetchRequest.fetchLimit = 1

            return try context
                .fetch(fetchRequest).first?
                .mapToTodoTask()
        }
    }

    func saveTodoTask(todoTask: TodoTask) async throws {
        try await saveTodoTasks(todoTasks: [todoTask])
    }

    func saveTodoTasks(todoTasks: [TodoTask]) async throws {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        try await context.perform {
            todoTasks.forEach { todoTask in
                let taskEntity = TaskEntity(context: context)
                taskEntity.mapFromTodoTask(todoTask)
            }
            try context.save()
        }
    }

    func updateTodoTask(todoTask: TodoTask) async throws {
        let context = persistentContainer.newBackgroundContext()
        try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", todoTask.id as CVarArg)
            if let taskEntity = try context.fetch(fetchRequest).first {
                taskEntity.title = todoTask.title
                taskEntity.taskDescription = todoTask.description
                taskEntity.isCompleted = todoTask.isCompleted
            }
            try context.save()
        }
    }

    func deleteTodoTask(id: UUID) async throws {
        let context = persistentContainer.newBackgroundContext()
        try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            if let taskEntity = try context.fetch(fetchRequest).first {
                context.delete(taskEntity)
            }
            try context.save()
        }
    }

    func searchTodoTasks(query: String) async throws -> [TodoTask] {
        let context = persistentContainer.newBackgroundContext()
        return try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[c] %@ OR taskDescription CONTAINS[c] %@", query, query)
            let taskEntities = try context.fetch(fetchRequest)
            return taskEntities.map { $0.mapToTodoTask() }
        }
    }
}
