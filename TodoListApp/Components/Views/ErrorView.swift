//
//  ErrorView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct ErrorView: View {

    // MARK: - Properties

    let message: String
    let action: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 12) {
            image
            errorMessage
            actionButton
        }
    }
}

private extension ErrorView {

    // MARK: - View Components

    var image: some View {
        Image(systemName: Constants.SFSymbol.triangle)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(.orange)
    }

    var errorMessage: some View {
        Text(message)
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding(.horizontal, 16)
    }

    var actionButton: some View {
        Button(action: action) {
            Label(
                Constants.String.repeatString,
                systemImage: Constants.SFSymbol.clockwise
            )
            .font(.headline)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue.opacity(0.1))
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ErrorView(message: "ERROR") { }
}
