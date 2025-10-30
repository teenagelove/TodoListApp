//
//  RootView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 29.10.2025.
//

import SwiftUI

struct RootView: View {
    @State var navigationService: NavigationServiceProtocol

    var body: some View {
        NavigationStack(path: $navigationService.items) {
            TodoListAssembly.build(navigationService: navigationService)
                .navigationDestination(for: Module.self) { module in
                    switch module {
//                    case .todoDetail(let TodoTask):
//                        TodoDetailAssembly.build(todoTask: TodoTask)
                    default:
                        fatalError()
                    }
                }
        }
    }
}

#Preview {
}
