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
    
    func fetchTodoTasks() async { /* Do nothing for mock */ }
    func didRequestDeleteTask(todoTask: TodoTask) { /* Do nothing for mock */ }
    func didSelectTask(todoTask: TodoTask) { /* Do nothing for mock */ }
    func didTapAddButton() { /* Do nothing for mock */ }
    func didCompleteTaskToggle(todoTask: TodoTask) { /* Do nothing for mock */ }
    func didUpdateSearch(query: String) { /* Do nothing for mock */ }

    static func loadedMock() -> MockTodoListPresenter {
        return MockTodoListPresenter(state: .loaded(TodoTask.mockTodoTasks))
    }
}

// MARK: - Расширение для TodoListModule для удобства превью

extension TodoListAssembly {
    static func buildPreview(state: TodoListPresenter.State) -> some View {
        return TodoListView(presenter: MockTodoListPresenter(state: state))
    }

    static func buildPreview() -> some View {
        return TodoListView(presenter: MockTodoListPresenter.loadedMock())
    }
}
