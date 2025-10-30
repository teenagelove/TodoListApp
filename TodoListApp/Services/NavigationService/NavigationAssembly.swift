//
//  NavigationServiceAssembly.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

final class NavigationAssembly: NavigationAssemblyProtocol {
    
    static let shared: any NavigationServiceProtocol = NavigationService()

    private init() { }
}
