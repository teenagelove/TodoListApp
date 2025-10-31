
//
//  TodoDetailRouter.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import Foundation

final class TodoDetailRouter: TodoDetailRouterProtocol {

    // MARK: - Dependencies

    private let navigationService: NavigationServiceProtocol

    // MARK: - Initialization

    init(navigationService: NavigationServiceProtocol) {
        self.navigationService = navigationService
    }

    // MARK: - Public Methods

    func dismiss() {
        navigationService.pop()
    }
}
