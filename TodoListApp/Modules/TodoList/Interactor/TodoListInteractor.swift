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

    func fetchTodoTasks() async throws -> [TodoTask] {
        let localTodoTasks = try await storageService.fetchTodoTasks()

        if !localTodoTasks.isEmpty {
            return localTodoTasks
        }

        let networkTodoTasks = try await networkService.fetchTodoTasks()

        try await self.storageService.saveTodoTasks(todoTasks: networkTodoTasks)

        return try await storageService.fetchTodoTasks()
    }

    func saveTodoTask(_ todoTask: TodoTask) async throws {
        try await storageService.saveTodoTask(todoTask: todoTask)
    }

    func updateTodoTask(_ todoTask: TodoTask) async throws {
        try await storageService.updateTodoTask(todoTask: todoTask)
    }

    func deleteTodoTask(id: UUID) async throws {
        try await storageService.deleteTodoTask(id: id)
    }

    func searchTodoTasks(query: String) async throws -> [TodoTask] {
        try await storageService.searchTodoTasks(query: query)
    }
}
