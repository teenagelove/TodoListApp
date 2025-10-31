//
//  TodoTask.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

struct TodoTask: Identifiable, Hashable, Codable {
    let id: UUID
    let title: String
    let description: String
    let isCompleted: Bool
    let createdAt: Date

    private enum CodingKeys: String, CodingKey {
        case title = "todo"
        case isCompleted = "completed"
    }

    init(
        id: UUID = UUID(),
        title: String,
        description: String = "",
        isCompleted: Bool = false,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let todo = try container.decode(String.self, forKey: .title)
        let completed = try container.decode(Bool.self, forKey: .isCompleted)

        self.id = UUID()
        self.title = todo
        self.isCompleted = completed

        self.description = title
        self.createdAt = Date()
    }
}
