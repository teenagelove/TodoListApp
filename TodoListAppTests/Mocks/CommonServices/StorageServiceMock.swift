
//
//  StorageServiceMock.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import Foundation
import CoreData
@testable import TodoListApp

final class StorageServiceMock: StorageServiceProtocol {
    // MARK: - Properties for controlling behavior

    var fetchTodoTasksResult: Result<[TodoTask], Error> = .success([])
    var searchTodoTasksResult: Result<[TodoTask], Error> = .success([])
    var fetchTodoTaskByIdResult: Result<TodoTask?, Error> = .success(nil)

    // MARK: - Properties for tracking calls

    private(set) var fetchTodoTasksCallCount = 0
    private(set) var searchTodoTasksCallCount = 0
    private(set) var fetchTodoTaskByIdCallCount = 0
    private(set) var saveTodoTaskCallCount = 0
    private(set) var saveTodoTasksCallCount = 0
    private(set) var updateTodoTaskCallCount = 0
    private(set) var deleteTodoTaskCallCount = 0

    private(set) var receivedQuery: String?
    private(set) var receivedTodoTask: TodoTask?
    private(set) var receivedTodoTasks: [TodoTask]?
    private(set) var receivedId: UUID?

    // MARK: - Protocol Implementation

    func fetchTodoTasks() async throws -> [TodoTask] {
        fetchTodoTasksCallCount += 1
        return try fetchTodoTasksResult.get()
    }

    func searchTodoTasks(query: String) async throws -> [TodoTask] {
        searchTodoTasksCallCount += 1
        receivedQuery = query
        return try searchTodoTasksResult.get()
    }

    func fetchTodoTaskById(id: UUID) async throws -> TodoTask? {
        fetchTodoTaskByIdCallCount += 1
        receivedId = id
        return try fetchTodoTaskByIdResult.get()
    }

    func saveTodoTask(todoTask: TodoTask) async throws {
        saveTodoTaskCallCount += 1
        receivedTodoTask = todoTask
    }

    func saveTodoTasks(todoTasks: [TodoTask]) async throws {
        saveTodoTasksCallCount += 1
        receivedTodoTasks = todoTasks
    }

    func updateTodoTask(todoTask: TodoTask) async throws {
        updateTodoTaskCallCount += 1
        receivedTodoTask = todoTask
    }

    func deleteTodoTask(id: UUID) async throws {
        deleteTodoTaskCallCount += 1
        receivedId = id
    }

    // MARK: - Helper for resetting state

    func reset() {
        fetchTodoTasksCallCount = 0
        searchTodoTasksCallCount = 0
        fetchTodoTaskByIdCallCount = 0
        saveTodoTaskCallCount = 0
        saveTodoTasksCallCount = 0
        updateTodoTaskCallCount = 0
        deleteTodoTaskCallCount = 0

        receivedQuery = nil
        receivedTodoTask = nil
        receivedTodoTasks = nil
        receivedId = nil
    }
}
