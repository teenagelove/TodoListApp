//
//  DependencyContainerAssembly.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

struct DependencyContainerAssembly: DependencyContainerAssemblyProtocol {
    
    func build() -> DependencyContainerProtocol {
        DependencyContainer(
            navigationService: NavigationService(),
            networkService: NetworkService(),
            storageService: CoreDataService()
        )
    }
}
