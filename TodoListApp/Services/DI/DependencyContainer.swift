
//
//  DependencyContainer.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

final class DependencyContainer: DependencyContainerProtocol {

    // MARK: - Properties

    let navigationService: NavigationServiceProtocol
    let networkService: NetworkServiceProtocol
    let storageService: StorageServiceProtocol

    // MARK: - Initialization

    init(
        navigationService: NavigationServiceProtocol,
        networkService: NetworkServiceProtocol,
        storageService: StorageServiceProtocol
    ) {
        self.navigationService = navigationService
        self.networkService = networkService
        self.storageService = storageService
    }
}
