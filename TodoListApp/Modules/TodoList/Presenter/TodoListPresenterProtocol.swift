//
//  TodoListPresenterProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

protocol TodoListPresenterProtocol {
    var state: TodoListPresenter.State { get }

    func fetchTodoTasks() async
    func didUpdateSearch(query: String)
    func didRequestDeleteTodoTask(todoTask: TodoTask)
    func didSelectTodoTask(todoTask: TodoTask)
    func didTapAddButton()
    func didToggleTodoTaskCompletion(todoTask: TodoTask)
}
