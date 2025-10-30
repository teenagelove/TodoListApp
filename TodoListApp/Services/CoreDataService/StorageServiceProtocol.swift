//
//  CoreDataServiceProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

protocol StorageServiceProtocol {
    func fetchTodos() async throws -> [TodoTask]
    func saveTodo(todoTask: TodoTask) async throws
    func updateTodo(todoTask: TodoTask) async throws
    func deleteTodo(id: UUID) async throws
}
