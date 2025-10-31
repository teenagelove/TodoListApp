//
//  Route.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 29.10.2025.
//

import Foundation

enum Route: Hashable {
    case todoList, todoDetail(TodoTask)
}
