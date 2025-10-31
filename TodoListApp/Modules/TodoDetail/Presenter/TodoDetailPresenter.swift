
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
    private let task: TodoTask

    // MARK: - State
    
    var title: String
    var description: String
    var isFailed: Bool = false

    var dateString: String {
        task.createdAt.shortDate
    }

    // MARK: - Initialization

    init(
        task: TodoTask,
        interactor: TodoDetailInteractorProtocol,
        router: TodoDetailRouterProtocol
    ) {
        self.task = task
        self.interactor = interactor
        self.router = router

        self.title = task.title
        self.description = task.description
    }

    // MARK: - Public Methods

    func save() async {
        guard !title.isEmpty && !description.isEmpty else {
            router.dismiss()
            return
        }

        isFailed = false

        let task = TodoTask(
            id: task.id,
            title: title.isEmpty ? description : title,
            description: description,
            isCompleted: task.isCompleted,
            createdAt: task.createdAt
        )

        do {
            try await interactor.saveTodo(task)
            router.dismiss()
        } catch {
            isFailed = true
        }
    }
}
