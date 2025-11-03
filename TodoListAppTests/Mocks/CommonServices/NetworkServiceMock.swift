//
//  NetworkServiceMock.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import Foundation
@testable import TodoListApp

final class NetworkServiceMock: NetworkServiceProtocol {
    var fetchTodoTasksResult: Result<[TodoTask], Error> = .success([])
    private(set) var fetchTodoTasksCallCount = 0

    func fetchTodoTasks() async throws -> [TodoTask] {
        fetchTodoTasksCallCount += 1
        return try fetchTodoTasksResult.get()
    }

    func reset() {
        fetchTodoTasksCallCount = 0
    }
}
