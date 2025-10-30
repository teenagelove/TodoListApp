//
//  NavigationService.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Observation

@Observable
final class NavigationService: NavigationServiceProtocol {
    var items: [Module] = []
}
