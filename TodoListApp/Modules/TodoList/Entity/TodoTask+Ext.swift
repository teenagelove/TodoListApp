//
//  TodoTask+Ext.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//


extension TodoTask {
    var toggledCompletion: TodoTask {
        TodoTask(
            id: id,
            title: title,
            description: description,
            isCompleted: !isCompleted,
            createdAt: createdAt,
        )
    }
}
