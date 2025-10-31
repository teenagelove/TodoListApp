//
//  TodoListView.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 30.10.2025.
//

import SwiftUI

struct TodoListView: View {

    // MARK: - State

    @State var presenter: TodoListPresenterProtocol

    // MARK: - Body

    var body: some View {
        contentView
            .navigationTitle("Задачи")
            .toolbar { toolbarContent }
            .toolbarRole(.editor)
            .task {
                await presenter.fetchTodos()
            }
    }
}

// MARK: - Private Views
private extension TodoListView {

    @ViewBuilder
    var contentView: some View {
        switch presenter.state {
        case .idle, .loading:
            loadingView
        case .error(let message):
            ErrorView(message: message) {
                Task {
                    await presenter.fetchTodos()
                }
            }
        case .loaded(let tasks):
            if tasks.isEmpty {
                emptyTasksView
            } else {
                tasksListView(tasks: tasks)
            }
        }
    }

    var loadingView: some View {
        ProgressView()
    }

    var emptyTasksView: some View {
        Text("Список задач пуст.")
    }

    func tasksListView(tasks: [TodoTask]) -> some View {
        List {
            ForEach(tasks) { task in
                Button {
                    presenter.didSelectTask(task: task)
                } label: {
                    TodoRowView(task: task)
                }
                .buttonStyle(.plain)
            }
            .onDelete(perform: presenter.didRequestDeleteTasks)
        }
        .listStyle(.plain)
    }

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Spacer()
        }

        if case .loaded(let tasks) = presenter.state {
            ToolbarItem(placement: .bottomBar) {
                Text("\(tasks.count) задач")
                    .font(.regular11)
            }
        }

        ToolbarItem(placement: .bottomBar) {
            Spacer()
        }

        ToolbarItem(placement: .bottomBar) {
            Button {
                // TODO: - Add task action
            } label: {
                Image(systemName: Constants.SFSymbol.pencil)
            }
        }
    }
}

#Preview {
    TodoListAssembly.buildPreview(state: .loaded([
        TodoTask(title: "Молоко", description: "Купить молока", isCompleted: false),
        TodoTask(title: "Счета", description: "Заплатить по счетам", isCompleted: true),
        TodoTask(title: "Мама", description: "Позвонить маме", isCompleted: false)
    ]))
}
