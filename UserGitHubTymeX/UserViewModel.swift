//
//  UserViewModel.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import Foundation
import SwiftUI

class UserViewModel : ObservableObject {
    @Published var users:  [User] = []
    @Published var selectedUserDetail: UserDetail?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var isLoadingUserDetail: Bool = false
    @Published var userDetailError: Error?

    private var userService = UserService()
    @Published var since = 0
    
    
    init() {
        loadCachedUsers()
    }
    
    /// Loads GitHub users from the API.
    ///
    /// This function fetches users, updates the view model's state,
    /// and handles caching. It manages loading state, error handling,
    /// and updates the user list and pagination.
    func loadUsers(loadMore: Bool = false) {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        let startingSince = loadMore ? since : 0
        
        userService.fetchUsers(since: startingSince) { [weak self] result in
            DispatchQueue.main.async {
                
                
                switch result {
                case .success(let newUsers):
                    if loadMore {
                        self?.users.append(contentsOf: newUsers)
                    } else {
                        self?.users = newUsers
                    }
                    
                    if let lastUserId = newUsers.last?.id {
                        self?.since = lastUserId
                    } else if !loadMore {
                        self?.since = 0
                    }
                    self?.isLoading = false
                    self?.cacheUsers(self?.users ?? [])
                case .failure(let fetchError):
                    self?.error = fetchError
                    self?.isLoading = false
                    print("Error fetching users: \(fetchError)")
                }
            }
        }
    }
    
    /// Fetches detailed information for a specific GitHub user.
    ///
    /// This function calls the UserService to retrieve detailed information for a given user.
    /// It updates the `selectedUserDetail` property with the fetched data or logs an error if the fetch fails.
    ///
    /// - Parameter loginUserName: The username of the GitHub user to fetch details for.
    func loadUserDetail(for loginUserName: String) {
        isLoadingUserDetail = true
        userDetailError = nil
        
        userService.fetchUserDetail(loginUserName: loginUserName) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingUserDetail = false
                
                switch result {
                case .success(let userDetails):
                    self?.selectedUserDetail = userDetails
                    NSLog("Fetching user details: \(userDetails)")
                case .failure(let error):
                    self?.userDetailError = error
                    print("Error fetching user details: \(error)")
                }
            }
        }
    }

    /// Caches the provided users in UserDefaults.
    ///
    /// This function encodes the given array of users and stores it in UserDefaults
    /// for later retrieval. If an error occurs during encoding, it's logged to the console.
    ///
    /// - Parameter users: An array of User objects to be cached.
    private func cacheUsers(_ users: [User]) {
        do {
            let encodedData = try JSONEncoder().encode(users)
            UserDefaults.standard.set(encodedData, forKey: "cachedUsers")
        } catch {
            print("Error caching users: \(error)")
        }
    }
       
    /// Loads previously cached users from UserDefaults.
    ///
    /// This function attempts to retrieve and decode user data stored in UserDefaults
    /// under the key "cachedUsers". If successful, it updates the `users` array and
    /// the `since` property. If an error occurs during decoding, it's printed to the console.
    private func loadCachedUsers() {
           if let cachedUsersData = UserDefaults.standard.data(forKey: "cachedUsers") {
               do {
                   let decodedUsers = try JSONDecoder().decode([User].self, from: cachedUsersData)
                   DispatchQueue.main.async {
                       self.users = decodedUsers
                       self.since = decodedUsers.last?.id ?? 0
                   }
               } catch {
                   print("Error decoding cached users: \(error)")
               }
           }
    }
}
