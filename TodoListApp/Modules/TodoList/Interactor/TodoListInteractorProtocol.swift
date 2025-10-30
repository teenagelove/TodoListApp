//
//  TodoListInteractorProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

protocol TodoListInteractorProtocol {
    func fetchTodos() async throws -> [TodoTask]
    func saveTodo(_ todoTask: TodoTask) async throws
    func updateTodo(_ todoTask: TodoTask) async throws
    func deleteTodo(id: UUID) async throws
}
