//
//  StorageServiceProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

protocol StorageServiceProtocol {
    func fetchTodoTasks() async throws -> [TodoTask]
    func searchTodoTasks(query: String) async throws -> [TodoTask]
    func fetchTodoTaskById(id: UUID) async throws -> TodoTask?
    func saveTodoTask(todoTask: TodoTask) async throws
    func saveTodoTasks(todoTasks: [TodoTask]) async throws
    func updateTodoTask(todoTask: TodoTask) async throws
    func deleteTodoTask(id: UUID) async throws
}
