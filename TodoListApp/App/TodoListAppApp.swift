//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 29.10.2025.
//

import SwiftUI

@main
struct TodoListAppApp: App {

    // MARK: - Properties

    private let container: DependencyContainerProtocol

    // MARK: - Initialization

    init() {
        let assembly = DependencyContainerAssembly()
        self.container = assembly.build()
    }

    init(assembly: DependencyContainerAssemblyProtocol) {
        self.container = assembly.build()
    }

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            RootView(container: container)
                .preferredColorScheme(.dark)
        }
    }
}
