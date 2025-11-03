//
//  TodoDetailAssembly.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct TodoDetailAssembly {

    // MARK: - Public Methods

    static func build(
        container: DependencyContainerProtocol,
        todoTask: TodoTask
    ) -> some View {
        let interactor = TodoDetailInteractor(
            storageService: container.storageService
        )

        let router = TodoDetailRouter(
            navigationService: container.navigationService
        )

        let presenter = TodoDetailPresenter(
            todoTask: todoTask,
            interactor: interactor,
            router: router
        )

        return TodoDetailView(presenter: presenter)
    }
}
