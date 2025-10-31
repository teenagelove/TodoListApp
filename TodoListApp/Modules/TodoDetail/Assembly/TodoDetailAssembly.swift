//
//  TodoDetailAssembly.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct TodoDetailAssembly {
    static func build(
        container: DependencyContainerProtocol,
        todo: TodoTask
    ) -> some View {
        TodoDetailView(todo: todo)
    }
}
