//
//  TodoListAssembly.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import SwiftUI

final class TodoListAssembly: ViewAssemblyProtocol {
    
    static func build() -> TodoListView {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        
        let interactor  = TodoListInteractor(
            networkService: networkService,
            coreDataService: coreDataService
        )
        
        let router = TodoListRouter(
            navigationService: NavigationAssembly.build()
        )
        
        let presenter = TodoListPresenter(
            interactor: interactor,
            router: router
        )
        
        return TodoListView(presenter: presenter)
    }
}
