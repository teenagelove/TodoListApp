//
//  TodoListAssembly+Preview.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 03.11.2025.
//

import SwiftUI

extension TodoListAssembly {
    static func buildPreview(state: TodoListPresenter.State) -> some View {
        return TodoListView(presenter: MockTodoListPresenter(state: state))
    }

    static func buildPreview() -> some View {
        return TodoListView(presenter: MockTodoListPresenter.loadedMock())
    }
}
