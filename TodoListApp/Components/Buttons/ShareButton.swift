//
//  ShareButton.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 02.11.2025.
//

import SwiftUI

struct ShareButton: View {

    // MARK: - Properties

    let todoTask: TodoTask

    // MARK: - Body

    var body: some View {
        ShareLink(item: generateShareLink()) {
            Label(Constants.String.shareString, image: .share)
        }
    }
}

// MARK: - Private Methods

private extension ShareButton {
    func generateShareLink() -> String {
        return """
        \(todoTask.title)\n
        \(todoTask.createdAt.shortDate)\n
        \(todoTask.description)
        """
    }
}

#Preview {
    ShareButton(todoTask: TodoTask.mockTodoTask)
}
