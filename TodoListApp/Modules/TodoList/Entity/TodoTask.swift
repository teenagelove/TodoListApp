//
//  Todo.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

struct TodoTask: Identifiable, Equatable, Hashable, Decodable {
    let id = UUID()
    let header: String
    let description: String
    let isCompleted: Bool
    let createdAt: String
}

