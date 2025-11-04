//
//  TodoListInteractorTests.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import XCTest
@testable import TodoListApp

final class TodoListInteractorTests: XCTestCase {

    // MARK: - Dependencies

    private var sut: TodoListInteractor!
    private var networkServiceMock: NetworkServiceMock!
    private var storageServiceMock: StorageServiceMock!

    // MARK: - Test Life Cycle

    override func setUp() {
        super.setUp()
        // Given
        networkServiceMock = NetworkServiceMock()
        storageServiceMock = StorageServiceMock()
        sut = TodoListInteractor(
            networkService: networkServiceMock,
            storageService: storageServiceMock
        )
    }

    override func tearDown() {
        sut = nil
        networkServiceMock = nil
        storageServiceMock = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testFetchTodos_whenDatabaseIsEmpty_shouldLoadFromNetworkAndSave() async throws {
        // Given
        let networkTasks = TodoTask.mockTodoTasks
        storageServiceMock.fetchTodoTasksResult = .success([])
        networkServiceMock.fetchTodoTasksResult = .success(networkTasks)

        // When
        _ = try await sut.fetchTodoTasks()

        // Then
        XCTAssertEqual(storageServiceMock.fetchTodoTasksCallCount, 2, "Should fetch from storage twice (initial check and final return)")
        XCTAssertEqual(networkServiceMock.fetchTodoTasksCallCount, 1, "Should fetch from network once")
        XCTAssertEqual(storageServiceMock.saveTodoTasksCallCount, 1, "Should save to storage once")
        XCTAssertEqual(storageServiceMock.receivedTodoTasks?.count, networkTasks.count, "Should save the correct number of tasks")
    }

    func testFetchTodos_whenDatabaseIsNotEmpty_shouldLoadFromDatabase() async throws {
        // Given
        let localTasks = TodoTask.mockTodoTasks
        storageServiceMock.fetchTodoTasksResult = .success(localTasks)

        // When
        let resultTasks = try await sut.fetchTodoTasks()

        // Then
        XCTAssertEqual(storageServiceMock.fetchTodoTasksCallCount, 1, "Should fetch from storage once")
        XCTAssertEqual(networkServiceMock.fetchTodoTasksCallCount, 0, "Should NOT fetch from network")
        XCTAssertEqual(storageServiceMock.saveTodoTasksCallCount, 0, "Should NOT save to storage")
        XCTAssertEqual(resultTasks.count, localTasks.count, "Should return the tasks from local storage")
    }
}
