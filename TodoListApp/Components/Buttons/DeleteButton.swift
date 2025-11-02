//
//  DeleteButton.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 02.11.2025.
//

import SwiftUI

struct DeleteButton: View {
    let action: (() -> Void)?

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
