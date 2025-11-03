//
//  DeleteButton.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 02.11.2025.
//

import SwiftUI

struct DeleteButton: View {

    // MARK: - Properties

    let action: (() -> Void)?

    // MARK: - Body

    var body: some View {
        Button(role: .destructive) {
            action?()
        } label: {
            Label(Constants.String.deleteString, image: .trash)
        }
    }
}

#Preview {
    DeleteButton { }
}
