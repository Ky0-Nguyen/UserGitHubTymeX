//
//  UserServiceTests.swift
//  UserGitHubTymeXTests
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import XCTest
@testable import UserGitHubTymeX

final class UserServiceTests: XCTestCase {

    override func setUpWithError() throws {
        print("Setting up UserServiceTests")
    }

    override func tearDownWithError() throws {
        print("Tearing down UserServiceTests")
    }

    func testExample() throws {
        // Given
        let expectation = self.expectation(description: "Example test expectation")
        let service = UserService()
        
        // When
        service.fetchUsers(since: 0) { result in
            // Then
            switch result {
            case .success(let users):
                XCTAssertFalse(users.isEmpty, "Fetched users array should not be empty")
                XCTAssertGreaterThan(users.count, 0, "There should be at least one user fetched")
                
                if let firstUser = users.first {
                    XCTAssertGreaterThan(firstUser.id, 0, "User ID should be greater than 0")
                    XCTAssertFalse(firstUser.login.isEmpty, "User login should not be empty")
                    XCTAssertFalse(firstUser.avatar_url.isEmpty, "User avatar URL should not be empty")
                }
            case .failure(let error):
                XCTFail("Fetching users failed with error: \(error)")
            }
            
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Measure the performance of fetching users
            let service = UserService()
            let expectation = self.expectation(description: "Fetch users performance")
            
            service.fetchUsers(since: 0) { result in
                switch result {
                case .success(let users):
                    XCTAssertFalse(users.isEmpty, "Fetched users should not be empty")
                case .failure(let error):
                    XCTFail("Fetching users failed with error: \(error)")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }
    }
    
    
    func testFetchUsers() {
        let service = UserService()
        
        service.fetchUsers(since: 0) { result in
            switch result {
            case .success(let users):
                XCTAssertFalse(users.isEmpty)
            case .failure(let error):
                XCTFail("Error : \(error)")
            }
        }
    }

}
