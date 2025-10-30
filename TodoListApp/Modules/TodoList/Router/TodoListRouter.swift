//
//  TodoListRouter.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

final class TodoListRouter: TodoListRouterProtocol {
    
    private var navigationService: NavigationServiceProtocol

    init(navigationService: NavigationServiceProtocol) {
        self.navigationService = navigationService
    }

    func navigateToTodoDetail(todo: TodoTask) {
        navigationService.items.append(.todoDetail(todo))
    }
}
