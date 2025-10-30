//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 29.10.2025.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    @State var navigationService: NavigationServiceProtocol

    init() {
        navigationService = NavigationAssembly.build()
    }

    var body: some Scene {
        WindowGroup {
            RootView(navigationService: navigationService)
        }
    }
}
