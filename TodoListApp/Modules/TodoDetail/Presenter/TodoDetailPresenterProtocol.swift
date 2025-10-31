
//
//  TodoDetailPresenterProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import Foundation

@MainActor
protocol TodoDetailPresenterProtocol: Observable {
    var title: String { get set }
    var description: String { get set }
    var dateString: String { get }

    func save() async
}
