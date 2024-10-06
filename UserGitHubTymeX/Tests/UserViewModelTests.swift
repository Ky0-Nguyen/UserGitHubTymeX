//
//  UserViewModelTests.swift
//  UserGitHubTymeXTests
//
//  Created by Hổ's Macbook on 05/10/2024.
//

import XCTest
@testable import UserGitHubTymeX

final class UserViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Initialize any necessary objects or variables for testing
        // For example:
        // - Create a mock UserService
        // - Initialize the UserViewModel with the mock service
        // - Set up any test data that might be needed across multiple tests
        print("Setting up UserViewModelTests")
    }

    override func tearDownWithError() throws {
        // Clean up any resources or state that was set up for the tests
        // For example:
        // - Reset any mocked objects
        // - Clear any temporary data
        // - Release any held references
        print("Tearing down UserViewModelTests")
    }

    func testExample() throws {
        // Given
        let viewModel = UserViewModel()
        let expectation = XCTestExpectation(description: "Fetch users")
        
        // When
        viewModel.loadUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(viewModel.users.isEmpty, "Users array should not be empty after fetching")
            XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching")
            XCTAssertNil(viewModel.error, "Error should be nil after successful fetch")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Given
            let viewModel = UserViewModel()
            
            // When
            viewModel.loadUsers()
            
            // Then
            let expectation = XCTestExpectation(description: "Fetch users performance")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertFalse(viewModel.users.isEmpty, "Users array should not be empty after fetching")
                XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching")
                XCTAssertNil(viewModel.error, "Error should be nil after successful fetch")
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0)
        }
    }

}
