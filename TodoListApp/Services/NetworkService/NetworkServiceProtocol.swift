//
//  NetworkServiceProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

protocol NetworkServiceProtocol {
    func fetchTodoTasks() async throws -> [TodoTask]
}
