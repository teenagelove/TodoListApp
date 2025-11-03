//
//  TodoDetailInteractorMock.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import Foundation
@testable import TodoListApp

final class TodoDetailInteractorMock: TodoDetailInteractorProtocol {
    var saveTodoTaskShouldThrowError = false
    private(set) var saveTodoTaskCallCount = 0
    private(set) var receivedTodoTask: TodoTask?

    func saveTodoTask(_ todoTask: TodoTask) async throws {
        saveTodoTaskCallCount += 1
        receivedTodoTask = todoTask
        if saveTodoTaskShouldThrowError {
            throw NSError(domain: "TestError", code: 0, userInfo: nil)
        }
    }

    func reset() {
        saveTodoTaskShouldThrowError = false
        saveTodoTaskCallCount = 0
        receivedTodoTask = nil
    }
}
