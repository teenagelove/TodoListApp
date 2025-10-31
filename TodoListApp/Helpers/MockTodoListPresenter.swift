//
//  MockTodoListPresenter.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

// MARK: - Mock Presenter для превью
final class MockTodoListPresenter: TodoListPresenterProtocol {
    
    var state: TodoListPresenter.State
    
    init(state: TodoListPresenter.State) {
        self.state = state
    }
    
    func fetchTodos() async { /* Do nothing for mock */ }
    func didRequestDeleteTask(task: TodoTask) { /* Do nothing for mock */ }
    func didSelectTask(task: TodoTask) { /* Do nothing for mock */ }
    func didTapAddButton() { /* Do nothing for mock */ }
    func didCompleteTaskToggle(task: TodoTask) { /* Do nothing for mock */ }
}

// MARK: - Расширение для TodoListModule для удобства превью

extension TodoListAssembly {
    static func buildPreview(state: TodoListPresenter.State) -> some View {
        return TodoListView(presenter: MockTodoListPresenter(state: state))
    }
}
