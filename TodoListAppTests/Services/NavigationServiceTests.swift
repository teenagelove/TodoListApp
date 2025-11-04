//
//  NavigationServiceTests.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import XCTest
import SwiftUI
@testable import TodoListApp

@MainActor
final class NavigationServiceTests: XCTestCase {

    // MARK: - Dependencies

    private var sut: NavigationService!

    // MARK: - Test Life Cycle

    override func setUp() {
        super.setUp()
        sut = NavigationService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testPush_whenNewRouteIsPushed_shouldAppendToPath() {
        // Given
        XCTAssertEqual(sut.path.count, 0)
        let route = Route.todoDetail(TodoTask.mockTodoTask)

        // When
        sut.push(to: route)

        // Then
        XCTAssertEqual(sut.path.count, 1)
    }

    func testPop_whenPathIsNotEmpty_shouldRemoveLastRoute() {
        // Given
        let r1 = Route.todoList
        let r2 = Route.todoDetail(TodoTask.mockTodoTask)
        sut.push(to: r1)
        sut.push(to: r2)
        XCTAssertEqual(sut.path.count, 2)

        // When
        sut.pop()

        // Then
        XCTAssertEqual(sut.path.count, 1)
    }
}
