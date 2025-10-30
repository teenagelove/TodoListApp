//
//  TodoListPresenterProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import Foundation

protocol TodoListPresenterProtocol {
    func fetchTodos() async
    func deleteTodo(id: UUID) async
}
