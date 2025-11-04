//
//  TodoListInteractorMock.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import Foundation
@testable import TodoListApp

final class TodoListInteractorMock: TodoListInteractorProtocol {
    var fetchTodoTasksResult: Result<[TodoTask], Error> = .success([])
    var searchTodoTasksResult: Result<[TodoTask], Error> = .success([])

    private(set) var fetchTodoTasksCallCount = 0
    private(set) var searchTodoTasksCallCount = 0
    private(set) var saveTodoTaskCallCount = 0
    private(set) var updateTodoTaskCallCount = 0
    private(set) var deleteTodoTaskCallCount = 0

    private(set) var receivedQuery: String?
    private(set) var receivedTodoTask: TodoTask?
    private(set) var receivedId: UUID?

    func fetchTodoTasks() async throws -> [TodoTask] {
        fetchTodoTasksCallCount += 1
        return try fetchTodoTasksResult.get()
    }

    func searchTodoTasks(query: String) async throws -> [TodoTask] {
        searchTodoTasksCallCount += 1
        receivedQuery = query
        return try searchTodoTasksResult.get()
    }

    func saveTodoTask(_ todoTask: TodoTask) async throws {
        saveTodoTaskCallCount += 1
        receivedTodoTask = todoTask
    }

    func updateTodoTask(_ todoTask: TodoTask) async throws {
        updateTodoTaskCallCount += 1
        receivedTodoTask = todoTask
    }

    func deleteTodoTask(id: UUID) async throws {
        deleteTodoTaskCallCount += 1
        receivedId = id
    }

    func reset() {
        fetchTodoTasksCallCount = 0
        searchTodoTasksCallCount = 0
        saveTodoTaskCallCount = 0
        updateTodoTaskCallCount = 0
        deleteTodoTaskCallCount = 0
        receivedQuery = nil
        receivedTodoTask = nil
        receivedId = nil
    }
}
