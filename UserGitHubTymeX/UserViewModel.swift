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

    private let cacheManager = CacheManager.shared
    private let usersCacheKey = "cachedUsers"
    private let userDetailCachePrefix = "userDetail_"

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
    /// 
    /// - Parameter loadMore: A boolean indicating whether to load more users or start from the beginning.
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
    /// This function first checks the cache for user details. If found, it updates the view model immediately.
    /// Otherwise, it calls the UserService to retrieve detailed information for the given user.
    /// It updates the `selectedUserDetail` property with the fetched data or sets an error if the fetch fails.
    ///
    /// - Parameter loginUserName: The username of the GitHub user to fetch details for.
    func loadUserDetail(for loginUserName: String) {
        if let cachedUserDetail = cacheManager.get(forKey: userDetailCacheKey(for: loginUserName)),
           let userDetail = try? JSONDecoder().decode(UserDetail.self, from: cachedUserDetail) {
            self.selectedUserDetail = userDetail
            return
        }
        
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

    /// Caches the provided users using CacheManager.
    ///
    /// This function encodes the given array of users and stores it in CacheManager
    /// for later retrieval. If an error occurs during encoding, it's silently ignored.
    ///
    /// - Parameter users: An array of User objects to be cached.
    private func cacheUsers(_ users: [User]) {
        if let encodedData = try? JSONEncoder().encode(users) {
            cacheManager.set(encodedData, forKey: usersCacheKey)
        }
    }
    
    /// Loads previously cached users from CacheManager.
    ///
    /// This function attempts to retrieve user data stored in CacheManager
    /// under the key defined by `usersCacheKey`. If successful, it updates the `users` array and
    /// the `since` property on the main thread. If no cached data is found, no action is taken.
    private func loadCachedUsers() {
        if let cachedData = cacheManager.get(forKey: usersCacheKey),
           let decodedUsers = try? JSONDecoder().decode([User].self, from: cachedData) {
            DispatchQueue.main.async {
                self.users = decodedUsers
                self.since = decodedUsers.last?.id ?? 0
            }
        }
    }
   
    /// Generates a unique cache key for a user's detail information.
    ///
    /// This function creates a cache key by combining a prefix with the user's login name.
    /// This ensures that each user's details are stored under a unique key in the cache.
    ///
    /// - Parameter loginUserName: The login name of the user.
    /// - Returns: A string representing the unique cache key for the user's details.
    private func userDetailCacheKey(for loginUserName: String) -> String {
        return userDetailCachePrefix + loginUserName
    }
}
