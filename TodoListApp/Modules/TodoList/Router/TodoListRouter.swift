//
//  TodoListRouter.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

final class TodoListRouter: TodoListRouterProtocol {

    // MARK: - Dependencies

    private var navigationService: NavigationServiceProtocol

    // MARK: - Initialization

    init(navigationService: NavigationServiceProtocol) {
        self.navigationService = navigationService
    }

    // MARK: - Public Methods

    func navigateToTodoDetail(for todoTask: TodoTask) {
        navigationService.push(to: .todoDetail(todoTask))
    }
}
