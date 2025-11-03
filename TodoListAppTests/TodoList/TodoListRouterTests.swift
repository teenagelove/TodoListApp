
//
//  TodoListRouterTests.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import XCTest
@testable import TodoListApp

final class TodoListRouterTests: XCTestCase {

    // MARK: - Dependencies

    private var navigationService: NavigationServiceMock!
    private var sut: TodoListRouter!

    // MARK: - Test Life Cycle

    override func setUp() {
        super.setUp()
        // Given
        navigationService = NavigationServiceMock()
        sut = TodoListRouter(navigationService: navigationService)
    }

    override func tearDown() {
        navigationService = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testNavigateToTodoDetail_whenCalled_shouldPushDetailViewWithCorrectTask() {
        // Given
        let mockTask = TodoTask.mockTodoTask
        let expectedRoute = Route.todoDetail(mockTask)

        // When
        sut.navigateToTodoDetail(for: mockTask)

        // Then
        XCTAssertTrue(navigationService.pushCalled, "push(to:) should have been called on navigationService")
        XCTAssertEqual(navigationService.pushedRoute, expectedRoute, "The correct route should have been passed to navigationService")
    }
}
