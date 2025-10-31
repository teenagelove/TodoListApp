
//
//  TodoDetailInteractor.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import Foundation

final class TodoDetailInteractor: TodoDetailInteractorProtocol {

    // MARK: - Dependencies

    private let storageService: StorageServiceProtocol

    // MARK: - Initialization

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }

    // MARK: - Public Methods

    func saveTodo(_ todoTask: TodoTask) async throws {
        if let _ = try await storageService.fetchTodoById(id: todoTask.id) {
            try await storageService.updateTodo(todoTask: todoTask)
        } else {
            try await storageService.saveTodo(todoTask: todoTask)
        }
    }
}
