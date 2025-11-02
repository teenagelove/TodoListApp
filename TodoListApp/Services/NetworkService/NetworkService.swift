//
//  NetworkService.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {

    // MARK: - Properties

    private let decoder = JSONDecoder()
    private let session = URLSession.shared

    // MARK: - Public Methods

    func fetchTodoTasks() async throws -> [TodoTask] {
        guard let url = URL(string: Constants.API.baseURL) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }

        do {
            let todoList = try decoder.decode(TodoList.self, from: data)
            return todoList.todoTasks
        } catch {
            throw URLError(.cannotParseResponse)
        }
    }
}
