//
//  TodoListAssembly.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import SwiftUI

struct TodoListAssembly {

    // MARK: - Public Methods

    static func build(container: DependencyContainerProtocol) -> some View {
        let interactor  = TodoListInteractor(
            networkService: container.networkService,
            storageService: container.storageService
        )

        let router = TodoListRouter(
            navigationService: container.navigationService
        )

        let presenter = TodoListPresenter(
            interactor: interactor,
            router: router
        )
        
        return TodoListView(presenter: presenter)
    }
}
