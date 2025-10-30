//
//  TodoListView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import SwiftUI

struct TodoListView: View {
    @State var presenter: TodoListPresenterProtocol
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TodoListAssembly.build()
}
