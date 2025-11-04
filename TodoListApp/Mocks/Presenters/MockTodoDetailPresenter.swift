//
//  MockTodoDetailPresenter.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

// MARK: - Mock Presenter для превью

final class MockTodoDetailPresenter: TodoDetailPresenterProtocol {

    var title: String
    var description: String
    var dateString: String
    var isFailed: Bool = false

    func saveTodoTask() async { /* Do nothing for mock */ }

    init(title: String, description: String) {
        self.title = title
        self.description = description
        dateString = Date().shortDate
    }
}
