//
//  TodoList.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

struct TodoList: Decodable {
    let todoTasks: [TodoTask]
    
    private enum CodingKeys: String, CodingKey {
        case todoTasks = "todos"
    }
}
