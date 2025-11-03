//
//  TodoListPresenterTests.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import XCTest
@testable import TodoListApp

@MainActor
final class TodoListPresenterTests: XCTestCase {

    // MARK: - Dependencies

    private var sut: TodoListPresenter!
    private var interactorMock: TodoListInteractorMock!
    private var routerMock: TodoListRouterMock!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        // Given
        interactorMock = TodoListInteractorMock()
        routerMock = TodoListRouterMock()
        sut = TodoListPresenter(
            interactor: interactorMock,
            router: routerMock
        )
    }

    override func tearDown() {
        sut = nil
        interactorMock = nil
        routerMock = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testFetchTodos_whenInteractorSucceeds_shouldTransitionToLoadedState() async {
        // Given
        let tasks = TodoTask.mockTodoTasks
        interactorMock.fetchTodoTasksResult = .success(tasks)
        
        // When
        await sut.fetchTodoTasks()
        
        // Then
        guard case .loaded(let loadedTasks) = sut.state else {
            XCTFail("Presenter should be in the loaded state")
            return
        }
        XCTAssertEqual(loadedTasks.count, tasks.count)
        XCTAssertEqual(interactorMock.fetchTodoTasksCallCount, 1)
    }

    func testFetchTodos_whenInteractorFails_shouldTransitionToErrorState() async {
        // Given
        let testError = NSError(domain: "TestError", code: 123, userInfo: nil)
        interactorMock.fetchTodoTasksResult = .failure(testError)
        
        // When
        await sut.fetchTodoTasks()
        
        // Then
        guard case .error(let errorMessage) = sut.state else {
            XCTFail("Presenter should be in the error state")
            return
        }
        XCTAssertEqual(errorMessage, testError.localizedDescription)
        XCTAssertEqual(interactorMock.fetchTodoTasksCallCount, 1)
    }
}
