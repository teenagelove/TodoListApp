//
//  TodoTask+Mock.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 02.11.2025.
//

import Foundation

extension TodoTask {
    
    nonisolated static let mockTodoTasks: [TodoTask] = [
        TodoTask(title: "Молоко", description: "Купить молока", isCompleted: false),
        TodoTask(title: "Счета", description: "Заплатить по счетам", isCompleted: true),
        TodoTask(title: "Мама", description: "Позвонить маме", isCompleted: false),
        TodoTask(title: "Проект", description: "Закончить тестовое задание", isCompleted: false),
        TodoTask(title: "Спорт", description: "Сходить в спортзал", isCompleted: true)
    ]

    nonisolated static let mockTodoTask: TodoTask = mockTodoTasks[0]
}
