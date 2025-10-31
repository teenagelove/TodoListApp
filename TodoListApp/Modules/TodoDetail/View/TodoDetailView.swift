//
//  TodoDetailView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct TodoDetailView: View {
    // MARK: - Properties
    let todo: TodoTask

    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
    }
}

private extension TodoDetailView {
    // MARK: - View Components
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(todo.title)
                .font(.medium16)
            Text(todo.createdAt.shortDate)
                .font(.regular12)
            Text(todo.description)
                .font(.regular11)
        }
    }
}

#Preview {
    TodoDetailView(todo: TodoTask(title: "Check", description: "Description"))
}
