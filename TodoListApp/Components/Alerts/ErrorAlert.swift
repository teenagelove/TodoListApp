//
//  ErrorAlert.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 03.11.2025.
//

import SwiftUI

struct ErrorAlert: ViewModifier {

    // MARK: - Properties

    @Binding var isPresented: Bool
    let title: String
    let message: String
    let retryAction: (() -> Void)?

    // MARK: - Body

    func body(content: Content) -> some View {
        content.alert(isPresented: $isPresented) {
            if let retryAction {
                return Alert(
                    title: Text(title),
                    message: Text(message),
                    primaryButton:
                            .default(
                                Text(Constants.String.repeatString),
                                action: retryAction
                            ),
                    secondaryButton:
                            .cancel(Text(Constants.String.cancelString))
                )
            } else {
                return Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(Text(Constants.String.okString))
                )
            }
        }
    }
}

extension View {

    // MARK: - Public Methods

    func errorAlert(
        isPresented: Binding<Bool>,
        title: String = Constants.String.errorTitleString,
        message: String = Constants.String.errorDescriptionString,
        retryAction: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            ErrorAlert(
                isPresented: isPresented,
                title: title,
                message: message,
                retryAction: retryAction
            )
        )
    }
}
