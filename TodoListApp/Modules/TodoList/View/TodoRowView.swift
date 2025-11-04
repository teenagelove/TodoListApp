//
//  TodoRowView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct TodoRowView: View {

    // MARK: - Properties

    let todoTask: TodoTask

    // MARK: - Body

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            completionIcon
            taskDetailsView
        }
    }
}

// MARK: - Private Views
private extension TodoRowView {
    var completionIcon: some View {
        Image(
            systemName: todoTask.isCompleted
                ? Constants.SFSymbol.checkmarkedCircle
                : Constants.SFSymbol.circle
        )
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(todoTask.isCompleted ? .yellow : .gray)
    }

    var taskDetailsView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(todoTask.title)
                .font(.medium16)
                .foregroundStyle(todoTask.isCompleted ? .gray : .primary)
                .strikethrough(todoTask.isCompleted, color: .gray)

            Text(todoTask.description)
                .font(.regular12)
                .foregroundStyle(todoTask.isCompleted ? .gray : .primary)

            Text(todoTask.createdAt.shortDate)
                .font(.regular12)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    TodoRowView(todoTask: TodoTask.mockTodoTask)
        .frame(width: 300, height: 50)
}
