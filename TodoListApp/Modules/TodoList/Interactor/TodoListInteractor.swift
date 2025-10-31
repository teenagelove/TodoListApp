//
//  TodoListInteractor.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

final class TodoListInteractor: TodoListInteractorProtocol {

    // MARK: - Dependencies

    private let networkService: NetworkServiceProtocol
    private let storageService: StorageServiceProtocol

    // MARK: - Initialization

    init(
        networkService: NetworkServiceProtocol,
        storageService: StorageServiceProtocol
    ) {
        self.networkService = networkService
        self.storageService = storageService
    }

    // MARK: - Public Methods

    func fetchTodos() async throws -> [TodoTask] {
        let localTodos = try await storageService.fetchTodos()

        if !localTodos.isEmpty {
            return localTodos
        }

        let networkTodos = try await networkService.fetchTodos()

        try await self.storageService.saveTodos(todoTasks: networkTodos)

        return try await storageService.fetchTodos()
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
