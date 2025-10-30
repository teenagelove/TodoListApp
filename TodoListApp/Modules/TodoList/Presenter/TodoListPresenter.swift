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
    
    private let interactor: TodoListInteractorProtocol
    private let router: TodoListRouterProtocol
    var state: State = .idle
    
    init(
        interactor: TodoListInteractorProtocol,
        router: TodoListRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func fetchTodos() async {
        state = .loading
        do {
            let todos = try await interactor.fetchTodos()
            state = .loaded(todos)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func deleteTodo(id: UUID) async {
        do {
            if case .loaded(let todos) = state {
                try await interactor.deleteTodo(id: id)
                await fetchTodos()
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
