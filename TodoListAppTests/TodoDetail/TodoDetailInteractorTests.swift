//
//  TodoDetailInteractorTests.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import XCTest
@testable import TodoListApp

final class TodoDetailInteractorTests: XCTestCase {

    // MARK: - Dependencies

    private var sut: TodoDetailInteractor!
    private var storageServiceMock: StorageServiceMock!

    // MARK: - Test Life Cycle

    override func setUp() {
        super.setUp()
        // Given
        storageServiceMock = StorageServiceMock()
        sut = TodoDetailInteractor(storageService: storageServiceMock)
    }

    override func tearDown() {
        sut = nil
        storageServiceMock = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testSaveTodoTask_whenTaskExists_shouldCallUpdate() async throws {
        // Given
        let existingTask = TodoTask.mockTodoTask
        storageServiceMock.fetchTodoTaskByIdResult = .success(existingTask)

        // When
        try await sut.saveTodoTask(existingTask)

        // Then
        XCTAssertEqual(storageServiceMock.fetchTodoTaskByIdCallCount, 1, "Should check if task exists")
        XCTAssertEqual(storageServiceMock.updateTodoTaskCallCount, 1, "Should call update for existing task")
        XCTAssertEqual(storageServiceMock.saveTodoTaskCallCount, 0, "Should NOT call save for existing task")
    }

    func testSaveTodoTask_whenTaskIsNew_shouldCallSave() async throws {
        // Given
        let newTask = TodoTask.mockTodoTask
        storageServiceMock.fetchTodoTaskByIdResult = .success(nil) // Simulate task not found

        // When
        try await sut.saveTodoTask(newTask)

        // Then
        XCTAssertEqual(storageServiceMock.fetchTodoTaskByIdCallCount, 1, "Should check if task exists")
        XCTAssertEqual(storageServiceMock.saveTodoTaskCallCount, 1, "Should call save for new task")
        XCTAssertEqual(storageServiceMock.updateTodoTaskCallCount, 0, "Should NOT call update for new task")
    }
}
