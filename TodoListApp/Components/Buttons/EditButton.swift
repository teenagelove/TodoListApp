//
//  EditButton.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 02.11.2025.
//

import SwiftUI

struct EditButton: View {

    // MARK: - Properties

    let action: (() -> Void)?

    // MARK: - Body

    var body: some View {
        Button {
            action?()
        } label: {
            Label(Constants.String.editString, image: .pencil)
        }
    }
}

#Preview {
    EditButton { }
}
