//
//  TaskEntity+Ext.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

extension TaskEntity {

    // MARK: - Public Methods

    func mapToTodoTask() -> TodoTask {
        return TodoTask(
            id: self.id ?? UUID(),
            title: self.title ?? "",
            description: self.taskDescription ?? "",
            isCompleted: self.isCompleted,
            createdAt: self.createdAt ?? Date()
        )
    }

    func mapFromTodoTask(_ todoTask: TodoTask) {
        self.id = todoTask.id
        self.title = todoTask.title
        self.taskDescription = todoTask.description
        self.isCompleted = todoTask.isCompleted
        self.createdAt = todoTask.createdAt
    }
}
