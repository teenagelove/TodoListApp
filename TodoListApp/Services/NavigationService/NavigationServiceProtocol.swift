//
//  NavigationServiceProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import SwiftUI

protocol NavigationServiceProtocol {
    var path: NavigationPath { get set}
    func push(to route: Route)
    func pop()
}
