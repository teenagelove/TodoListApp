//
//  TodoListInteractor.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

final class TodoListInteractor: TodoListInteractorProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let storageService: StorageServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        coreDataService: StorageServiceProtocol
    ) {
        self.networkService = networkService
        self.storageService = coreDataService
    }
    
    func fetchTodos() async throws -> [TodoTask] {
        let todos = try await fetchTodosFromCoreData()
        
        return !todos.isEmpty ? todos : try await fetchTodosFromNetwork()
    }
    
    func saveTodo(_ todoTask: TodoTask) async throws {
        try await storageService.saveTodo(todoTask: todoTask)
    }
    
    func updateTodo(_ todoTask: TodoTask) async throws {
        try await storageService.updateTodo(todoTask: todoTask)
    }
    
    func deleteTodo(id: UUID) async throws {
        try await storageService.deleteTodo(id: id)
    }
}

private extension TodoListInteractor {
    func fetchTodosFromNetwork() async throws -> [TodoTask] {
        try await networkService.fetchTodos()
    }
    
    func fetchTodosFromCoreData() async throws -> [TodoTask] {
        try await storageService.fetchTodos()
    }
}
