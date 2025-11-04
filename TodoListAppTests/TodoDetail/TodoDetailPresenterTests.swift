//
//  TodoDetailPresenterTests.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import XCTest
@testable import TodoListApp

@MainActor
final class TodoDetailPresenterTests: XCTestCase {

    // MARK: - Dependencies

    private var sut: TodoDetailPresenter!
    private var interactorMock: TodoDetailInteractorMock!
    private var routerMock: TodoDetailRouterMock!

    // MARK: - Test Life Cycle

    override func setUp() {
        super.setUp()
        // Given
        interactorMock = TodoDetailInteractorMock()
        routerMock = TodoDetailRouterMock()
        sut = TodoDetailPresenter(
            todoTask: TodoTask.mockTodoTask,
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

    func testSaveTodoTask_whenSuccessful_shouldCallInteractorAndDismiss() async {
        // Given
        sut.title = "Test Title"
        sut.description = "Test Description"

        // When
        await sut.saveTodoTask()

        // Then
        XCTAssertEqual(interactorMock.saveTodoTaskCallCount, 1, "Should call interactor")
        XCTAssertEqual(routerMock.dismissCallCount, 1, "Should dismiss the view on success")
        XCTAssertFalse(sut.isFailed, "isFailed should be false on success")
    }

    func testSaveTodoTask_whenInteractorFails_shouldSetIsFailed() async {
        // Given
        sut.title = "Test Title"
        sut.description = "Test Description"
        interactorMock.saveTodoTaskShouldThrowError = true

        // When
        await sut.saveTodoTask()

        // Then
        XCTAssertEqual(interactorMock.saveTodoTaskCallCount, 1, "Should call interactor")
        XCTAssertTrue(sut.isFailed, "isFailed should be true on failure")
        XCTAssertEqual(routerMock.dismissCallCount, 0, "Should not dismiss the view on failure")
    }

    func testSaveTodoTask_whenTitleIsEmpty_shouldDismissWithoutSaving() async {
        // Given
        sut.title = ""
        sut.description = "Test Description"

        // When
        await sut.saveTodoTask()

        // Then
        XCTAssertEqual(interactorMock.saveTodoTaskCallCount, 0, "Should not call interactor if validation fails")
        XCTAssertEqual(routerMock.dismissCallCount, 1, "Should dismiss the view even if validation fails")
    }
}
