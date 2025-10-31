
import Foundation
import Observation
import SwiftUI

// MARK: - Mock Presenter для превью

@MainActor
@Observable
final class MockTodoListPresenter: TodoListPresenterProtocol {

    var state: TodoListPresenter.State
    
    init(state: TodoListPresenter.State) {
        self.state = state
    }
    
    func fetchTodos() async { /* Do nothing for mock */ }
    func didRequestDeleteTasks(at offsets: IndexSet) { /* Do nothing for mock */ }
    func didSelectTask(task: TodoTask) { /* Do nothing for mock */ }
}

// MARK: - Расширение для TodoListModule для удобства превью

extension TodoListAssembly {
    static func buildPreview(state: TodoListPresenter.State) -> some View {
        return TodoListView(presenter: MockTodoListPresenter(state: state))
    }
}
