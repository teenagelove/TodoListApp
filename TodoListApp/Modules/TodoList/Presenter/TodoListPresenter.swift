//
//  TodoListPresenter.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Observation
import Foundation

@MainActor
@Observable
final class TodoListPresenter: TodoListPresenterProtocol {

    enum State {
        case idle
        case loading
        case loaded([TodoTask])
        case error(String)
    }
    
    // MARK: - Dependencies
    
    private let interactor: TodoListInteractorProtocol
    private let router: TodoListRouterProtocol
    
    // MARK: - State
    
    var state: State = .idle
    
    // MARK: - Initialization
    
    init(
        interactor: TodoListInteractorProtocol,
        router: TodoListRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func fetchTodos() async {
        state = .loading

        do {
            let todos = try await interactor.fetchTodos()
            state = .loaded(todos)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func didRequestDeleteTasks(at offsets: IndexSet) {
        guard case .loaded(var tasks) = state, let index = offsets.first else { return }

        let taskToDelete = tasks[index]

        Task {
            do {
                try await interactor.deleteTodo(id: taskToDelete.id)
                tasks.remove(at: index)
                state = .loaded(tasks)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func didSelectTask(task: TodoTask) {
        router.navigateToTodoDetail(for: task)
    }
}
