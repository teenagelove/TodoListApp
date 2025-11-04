
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

    func saveTodoTask(_ todoTask: TodoTask) async throws {
        if let _ = try await storageService.fetchTodoTaskById(id: todoTask.id) {
            try await storageService.updateTodoTask(todoTask: todoTask)
        } else {
            try await storageService.saveTodoTask(todoTask: todoTask)
        }
    }
}
