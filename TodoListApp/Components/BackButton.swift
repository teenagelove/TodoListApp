//
//  BackButton.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button{
            dismiss()
        } label: {
            Image(systemName: Constants.SFSymbol.chevronLeft)
                .foregroundColor(.blue)
                .imageScale(.large)
        }
    }
}

#Preview {
    BackButton()
}
