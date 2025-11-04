//
//  TodoListRouterMock.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import Foundation
@testable import TodoListApp

final class TodoListRouterMock: TodoListRouterProtocol {
    private(set) var navigateToTodoDetailCallCount = 0
    private(set) var receivedTodoTask: TodoTask?

    func navigateToTodoDetail(for todoTask: TodoTask) {
        navigateToTodoDetailCallCount += 1
        receivedTodoTask = todoTask
    }

    func reset() {
        navigateToTodoDetailCallCount = 0
        receivedTodoTask = nil
    }
}
