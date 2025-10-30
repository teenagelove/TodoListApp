//
//  AppRoute.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

enum Module: Equatable, Hashable {
    case todoList, todoDetail(TodoTask)
}
