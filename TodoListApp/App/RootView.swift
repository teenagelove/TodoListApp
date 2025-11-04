//
//  RootView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 29.10.2025.
//

import SwiftUI

struct RootView: View {

    // MARK: - Dependencies

    let container: DependencyContainerProtocol
    @State var navigationService: NavigationServiceProtocol

    // MARK: - Initialization

    init(container: DependencyContainerProtocol) {
        self.container = container
        navigationService = container.navigationService
    }

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $navigationService.path) {
            TodoListAssembly.build(container: container)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .todoList:
                        EmptyView()
                    case .todoDetail(let todoTask):
                        TodoDetailAssembly
                            .build(container: container, todoTask: todoTask)
                    }
                }
        }
    }
}
