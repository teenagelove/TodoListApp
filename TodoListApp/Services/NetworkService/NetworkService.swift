//
//  NetworkService.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    private let decoder = JSONDecoder()

    func fetchTodos() async throws -> [TodoTask] {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        do {
            let response = try decoder.decode(TodoTask.self, from: data)
            return [response]
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
    }
}
