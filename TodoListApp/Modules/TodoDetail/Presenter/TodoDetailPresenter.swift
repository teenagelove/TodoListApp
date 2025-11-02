
//
//  TodoDetailPresenter.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import Observation
import Foundation

@MainActor
@Observable
final class TodoDetailPresenter: TodoDetailPresenterProtocol {

    // MARK: - Dependencies

    private let interactor: TodoDetailInteractorProtocol
    private let router: TodoDetailRouterProtocol
    private let todoTask: TodoTask

    // MARK: - State
    
    var title: String
    var description: String
    var isFailed: Bool = false

    var dateString: String {
        todoTask.createdAt.shortDate
    }

    // MARK: - Initialization

    init(
        todoTask: TodoTask,
        interactor: TodoDetailInteractorProtocol,
        router: TodoDetailRouterProtocol
    ) {
        self.todoTask = todoTask
        self.interactor = interactor
        self.router = router

        self.title = todoTask.title
        self.description = todoTask.description
    }

    // MARK: - Public Methods

    func saveTodoTask() async {
        guard !title.isEmpty && !description.isEmpty else {
            router.dismiss()
            return
        }

        isFailed = false

        let updatedTodoTask = TodoTask(
            id: todoTask.id,
            title: title.isEmpty ? description : title,
            description: description,
            isCompleted: todoTask.isCompleted,
            createdAt: todoTask.createdAt
        )

        do {
            try await interactor.saveTodoTask(updatedTodoTask)
            router.dismiss()
        } catch {
            isFailed = true
        }
    }
}
