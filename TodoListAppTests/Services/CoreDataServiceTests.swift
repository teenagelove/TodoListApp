//
//  CoreDataServiceTests.swift
//  TodoListAppTests
//
//  Created by Danil Kazakov on 03.11.2025.
//

import XCTest
import CoreData
@testable import TodoListApp

@MainActor
final class CoreDataServiceTests: XCTestCase {

    // MARK: - Dependencies

    private var sut: CoreDataService!
    private var persistentContainer: NSPersistentContainer!

    // MARK: - Test Life Cycle

    override func setUp() {
        super.setUp()
        persistentContainer = setupInMemoryPersistentContainer()
        sut = CoreDataService(persistentContainer: persistentContainer)
    }

    override func tearDown() {
        sut = nil
        persistentContainer = nil
        super.tearDown()
    }

    private func setupInMemoryPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "TodoListApp")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType // Use in-memory store for testing
        container.persistentStoreDescriptions = [description]
        return container
    }

    // MARK: - Tests

    func testSaveAndFetchTodoTask_whenNewTaskIsSaved_shouldBeRetrievable() async throws {
        // Given
        let newTask = TodoTask.mockTodoTask

        // When
        try await sut.saveTodoTask(todoTask: newTask)
        let fetchedTasks = try await sut.fetchTodoTasks()

        // Then
        XCTAssertEqual(fetchedTasks.count, 1)
        XCTAssertEqual(fetchedTasks.first?.id, newTask.id)
        XCTAssertEqual(fetchedTasks.first?.title, newTask.title)
    }

    func testFetchTodoTaskById_whenTaskExists_shouldReturnTask() async throws {
        // Given
        let newTask = TodoTask.mockTodoTask
        try await sut.saveTodoTask(todoTask: newTask)

        // When
        let fetchedTask = try await sut.fetchTodoTaskById(id: newTask.id)

        // Then
        XCTAssertNotNil(fetchedTask)
        XCTAssertEqual(fetchedTask?.id, newTask.id)
    }

    func testFetchTodoTaskById_whenTaskDoesNotExist_shouldReturnNil() async throws {
        // Given
        let nonExistentId = UUID()

        // When
        let fetchedTask = try await sut.fetchTodoTaskById(id: nonExistentId)

        // Then
        XCTAssertNil(fetchedTask)
    }

    func testUpdateTodoTask_whenTaskExists_shouldUpdateAndSaveChanges() async throws {
        // Given
        let originalTask = TodoTask.mockTodoTask
        try await sut.saveTodoTask(todoTask: originalTask)

        let updatedTitle = "Updated Title"
        let updatedTask = TodoTask(
            id: originalTask.id,
            title: updatedTitle,
            description: originalTask.description,
            isCompleted: !originalTask.isCompleted,
            createdAt: originalTask.createdAt
        )

        // When
        try await sut.updateTodoTask(todoTask: updatedTask)
        let fetchedTask = try await sut.fetchTodoTaskById(id: originalTask.id)

        // Then
        XCTAssertNotNil(fetchedTask)
        XCTAssertEqual(fetchedTask?.title, updatedTitle)
        XCTAssertEqual(fetchedTask?.isCompleted, updatedTask.isCompleted)
    }

    func testDeleteTodoTask_whenTaskExists_shouldBeRemovedFromStorage() async throws {
        // Given
        let taskToDelete = TodoTask.mockTodoTask
        try await sut.saveTodoTask(todoTask: taskToDelete)
        let initialCount = try await sut.fetchTodoTasks().count
        XCTAssertEqual(initialCount, 1)

        // When
        try await sut.deleteTodoTask(id: taskToDelete.id)
        let fetchedTasks = try await sut.fetchTodoTasks()

        // Then
        XCTAssertEqual(fetchedTasks.count, 0)
    }

    func testSearchTodoTasks_whenQueryMatches_shouldReturnMatchingTasks() async throws {
        // Given
        let task1 = TodoTask(title: "Buy Milk", description: "Grocery shopping", isCompleted: false)
        let task2 = TodoTask(title: "Walk Dog", description: "Morning routine", isCompleted: false)
        let task3 = TodoTask(title: "Pay Bills", description: "Monthly expenses", isCompleted: true)
        try await sut.saveTodoTasks(todoTasks: [task1, task2, task3])

        // When
        let searchResults = try await sut.searchTodoTasks(query: "milk")

        // Then
        XCTAssertEqual(searchResults.count, 1)
        XCTAssertEqual(searchResults.first?.title, "Buy Milk")
    }
}
