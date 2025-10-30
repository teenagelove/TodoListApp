//
//  CoreDataService.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import CoreData

final class CoreDataService: StorageServiceProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoListApp")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func fetchTodos() async throws -> [TodoTask] {
        [TodoTask]()
    }
    
    func saveTodo(todoTask: TodoTask) async throws {
        
    }
    
    func updateTodo(todoTask: TodoTask) async throws {
        
    }
    
    func deleteTodo(id: UUID) async throws {
        
    }
}
