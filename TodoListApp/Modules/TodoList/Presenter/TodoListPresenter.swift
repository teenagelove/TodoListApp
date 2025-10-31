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
    
    func didRequestDeleteTask(task: TodoTask) {
        guard case .loaded(var tasks) = state else { return }

        Task {
            do {
                try await interactor.deleteTodo(id: task.id)
                tasks.removeAll { $0.id == task.id }
                state = .loaded(tasks)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func didSelectTask(task: TodoTask) {
        router.navigateToTodoDetail(for: task)
    }

    func didTapAddButton() {
        let newTask = TodoTask()
        router.navigateToTodoDetail(for: newTask)
    }

    func didCompleteTaskToggle(task: TodoTask) {
        guard case .loaded(let tasks) = state else { return }

        let updatedTask = task.toggledCompletion

        updateTask(updatedTask)

        state = .loaded(tasks.map { $0.id == updatedTask.id ? updatedTask : $0 })
    }
}

private extension TodoListPresenter {
    func updateTask(_ task: TodoTask) {
        Task {
            do {
                try await interactor.updateTodo(task)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
