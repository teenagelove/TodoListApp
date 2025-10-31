//
//  TodoListAssemblyProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import SwiftUI

protocol TodoListAssemblyProtocol {
    associatedtype ContentView: View
    static func build(container: DependencyContainerProtocol) -> ContentView
}
