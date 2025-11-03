
//
//  TodoDetailRouterTests.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import XCTest
@testable import TodoListApp

final class TodoDetailRouterTests: XCTestCase {

    // MARK: - Dependencies

    private var navigationService: NavigationServiceMock!
    private var sut: TodoDetailRouter!

    // MARK: - Test Life Cycle

    override func setUp() {
        super.setUp()
        // Given
        navigationService = NavigationServiceMock()
        sut = TodoDetailRouter(navigationService: navigationService)
    }

    override func tearDown() {
        navigationService = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testDismiss_whenCalled_shouldCallPopOnNavigationService() {
        // Given
        // System is set up

        // When
        sut.dismiss()

        // Then
        XCTAssertTrue(navigationService.popCalled, "pop() should have been called on navigationService")
    }
}
