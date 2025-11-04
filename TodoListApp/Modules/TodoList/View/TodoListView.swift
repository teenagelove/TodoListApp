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
    @State private var searchText = ""

    // MARK: - Body

    var body: some View {
        contentView
            .navigationTitle(Constants.String.tasksString)
            .toolbar { toolbarContent }
            .task { await presenter.fetchTodoTasks() }
            .searchable(text: $searchText)
            .refreshable { await presenter.fetchTodoTasks() }
            .onChange(of: searchText) {
                presenter.didUpdateSearch(query: searchText)
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
                Task { await presenter.fetchTodoTasks() }
            }
        case .loaded(let todoTasks):
            if todoTasks.isEmpty {
                emptyTasksView
            } else {
                tasksListView(todoTasks: todoTasks)
            }
        }
    }

    var loadingView: some View {
        ProgressView()
    }

    var emptyTasksView: some View {
        if searchText.isEmpty {
            Text(Constants.String.emptyString)
                .font(.title2)
        } else {
            Text(Constants.String.emptySearchString)
                .font(.title2)
        }
    }

    func tasksListView(todoTasks: [TodoTask]) -> some View {
        List(todoTasks) { todoTask in
            TodoRowView(todoTask: todoTask)
                .onTapGesture { presenter.didToggleTodoTaskCompletion(todoTask: todoTask) }
                .contextMenu {
                    EditButton { presenter.didSelectTodoTask(todoTask: todoTask) }
                    ShareButton(todoTask: todoTask)
                    DeleteButton { presenter.didRequestDeleteTodoTask(todoTask: todoTask) }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    DeleteButton { presenter.didRequestDeleteTodoTask(todoTask: todoTask) }
                }
                .listRowSeparator(.hidden, edges: .top)
                .listRowSeparator(.visible, edges: .bottom)
        }
        .listStyle(.plain)
    }

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
       ToolbarItem(placement: .bottomBar) {
            Spacer()
        }

        if case .loaded(let todoTasks) = presenter.state {
            ToolbarItem(placement: .bottomBar) {
                Text("\(todoTasks.count) \(Constants.String.countTasksString)")
                    .font(.regular11)
                    .frame(minWidth: 50) // Hardcoded to prevent compression
            }
        }

        ToolbarItem(placement: .bottomBar) {
            Spacer()
        }

        ToolbarItem(placement: .bottomBar) {
            Button {
                presenter.didTapAddButton()
            } label: {
                Image(systemName: Constants.SFSymbol.pencil)
            }
        }
    }
}

#Preview {
    TodoListAssembly.buildPreview()
}
