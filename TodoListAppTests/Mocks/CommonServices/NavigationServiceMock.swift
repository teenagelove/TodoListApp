
//
//  NavigationServiceMock.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import SwiftUI
@testable import TodoListApp

final class NavigationServiceMock: NavigationServiceProtocol {
    var path = NavigationPath()

    private(set) var pushCalled = false
    private(set) var pushedRoute: Route?

    func push(to route: Route) {
        pushCalled = true
        pushedRoute = route
    }

    private(set) var popCalled = false
    func pop() {
        popCalled = true
    }
}
