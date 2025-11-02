//
//  TodoListInteractorProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

protocol TodoListInteractorProtocol {
    func fetchTodoTasks() async throws -> [TodoTask]
    func searchTodoTasks(query: String) async throws -> [TodoTask]
    func saveTodoTask(_ todoTask: TodoTask) async throws
    func updateTodoTask(_ todoTask: TodoTask) async throws
    func deleteTodoTask(id: UUID) async throws
}
