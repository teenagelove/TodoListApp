//
//  TodoListPresenterProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

@MainActor
protocol TodoListPresenterProtocol {
    var state: TodoListPresenter.State { get }

    func fetchTodos() async
    func didRequestDeleteTask(task: TodoTask)
    func didSelectTask(task: TodoTask)
    func didTapAddButton()
    func didCompleteTaskToggle(task: TodoTask)
}
