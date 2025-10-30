//
//  AssemblyProtocol.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import SwiftUI

protocol ViewAssemblyProtocol {
    associatedtype RootView: View
    static func build() -> RootView
}
