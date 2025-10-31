//
//  TaskEntity+Ext.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

extension TaskEntity {
    func toTodoTask() -> TodoTask {
        return TodoTask(
            id: self.id ?? UUID(),
            title: self.title ?? "",
            description: self.taskDescription ?? "",
            isCompleted: self.isCompleted,
            createdAt: self.createdAt ?? Date()
        )
    }
}
