
//
//  TodoDetailInteractorProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import Foundation

protocol TodoDetailInteractorProtocol {
    func saveTodoTask(_ todoTask: TodoTask) async throws
}

