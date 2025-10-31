//
//  TodoRowView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct TodoRowView: View {

    // MARK: - Properties

    let task: TodoTask

    // MARK: - Body

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(
                systemName: task.isCompleted
                    ? Constants.SFSymbol.checkmarkedCircle
                    : Constants.SFSymbol.circle
            )
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(task.isCompleted ? .yellow : .gray)

            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.medium16)
                    .foregroundStyle(task.isCompleted ? .gray : .primary)
                    .strikethrough(task.isCompleted, color: .gray)

                Text(task.description)
                    .font(.regular12)
                    .foregroundStyle(task.isCompleted ? .gray : .primary)

                Text(task.createdAt.shortDate)
                    .font(.regular12)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    TodoRowView(task: TodoTask(title: "Check", description: "Description"))
        .frame(width: 300, height: 50)
}
