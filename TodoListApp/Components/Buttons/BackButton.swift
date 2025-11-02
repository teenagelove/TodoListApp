//
//  BackButton.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct BackButton: View {
    let action: (() -> Void)?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button{
            if let action {
                action()
            } else {
                dismiss()
            }
        } label: {
            Image(systemName: Constants.SFSymbol.chevronLeft)
            Text(Constants.String.backString)
        }
    }
}

#Preview {
    BackButton { }
}
