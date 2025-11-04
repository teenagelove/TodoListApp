//
//  NavigationService.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class NavigationService: NavigationServiceProtocol {

    // MARK: - State

    var path = NavigationPath()

    // MARK: - Public Methods

    func push(to route: Route) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }
}
