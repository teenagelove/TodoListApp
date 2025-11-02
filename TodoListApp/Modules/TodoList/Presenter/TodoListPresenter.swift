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
    
    func fetchTodoTasks() async {
        state = .loading

        do {
            let todoTasks = try await interactor.fetchTodoTasks()
            state = .loaded(todoTasks)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func didRequestDeleteTodoTask(todoTask: TodoTask) {
        guard case .loaded(var todoTasks) = state else { return }

        Task {
            do {
                try await interactor.deleteTodoTask(id: todoTask.id)
                todoTasks.removeAll { $0.id == todoTask.id }
                state = .loaded(todoTasks)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func didSelectTodoTask(todoTask: TodoTask) {
        router.navigateToTodoDetail(for: todoTask)
    }

    func didTapAddButton() {
        let newTodoTask = TodoTask()
        router.navigateToTodoDetail(for: newTodoTask)
    }

    func didToggleTodoTaskCompletion(todoTask: TodoTask) {
        guard case .loaded(let todoTasks) = state else { return }

        let updatedTodoTask = todoTask.toggledCompletion

        updateTodoTask(updatedTodoTask)

        state = .loaded(todoTasks.map { $0.id == updatedTodoTask.id ? updatedTodoTask : $0 })
    }

    func didUpdateSearch(query: String) {
        Task {
            do {
                if query.isEmpty {
                    let todoTasks = try await interactor.fetchTodoTasks()
                    state = .loaded(todoTasks)
                } else {
                    let todoTasks = try await interactor.searchTodoTasks(query: query)
                    state = .loaded(todoTasks)
                }
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}

private extension TodoListPresenter {
    func updateTodoTask(_ todoTask: TodoTask) {
        Task {
            do {
                try await interactor.updateTodoTask(todoTask)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
