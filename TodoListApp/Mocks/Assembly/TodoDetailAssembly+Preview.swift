//
//  TodoDetailAssembly+Preview.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 03.11.2025.
//

extension TodoDetailAssembly {
    static var buildPreview: some View {
        let mockPresenter = MockTodoDetailPresenter(
            title: TodoTask.mockTodoTask.title,
            description: TodoTask.mockTodoTask.description
        )
        return TodoDetailView(presenter: mockPresenter)
    }
}
