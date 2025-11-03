//
//  TodoDetailView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import SwiftUI

struct TodoDetailView: View {

    // MARK: - State

    @State var presenter: TodoDetailPresenterProtocol

    // MARK: - Body

    var body: some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                        Task { await presenter.saveTodoTask() }
                    }
                }
            }
            .padding(.horizontal)
            .errorAlert(
                isPresented: $presenter.isFailed,
                retryAction: { Task { await presenter.saveTodoTask() } }
            )
    }
}

private extension TodoDetailView {

    // MARK: - View Components

    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading) {
            TextField(
                Constants.String.nameString,
                text: $presenter.title,
                axis: .vertical
            )
            .font(.bold34)

            Text(presenter.dateString)
                .font(.regular12)
                .foregroundStyle(.gray)

            TextField(
                Constants.String.descriptionString,
                text: $presenter.description,
                axis: .vertical
            )
            .font(.regular16)
            .padding(.top, 16)

            Spacer()
        }
    }
}

#Preview {
    TodoDetailView.buildPreview
}
