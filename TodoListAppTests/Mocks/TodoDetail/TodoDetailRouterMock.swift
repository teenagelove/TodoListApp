//
//  TodoDetailRouterMock.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import Foundation
@testable import TodoListApp

final class TodoDetailRouterMock: TodoDetailRouterProtocol {
    private(set) var dismissCallCount = 0

    func dismiss() {
        dismissCallCount += 1
    }

    func reset() {
        dismissCallCount = 0
    }
}
