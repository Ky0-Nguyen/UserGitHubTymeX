//
//  UserService.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import Foundation

class UserService {
    private let api = BaseAPI.shared
    
    /// Fetches a list of GitHub users.
    ///
    /// - Parameters:
    ///   - since: The integer ID of the last user seen. This is used for pagination.
    ///   - completion: A closure that is called with the result of the API request.
    ///                 It receives either an array of User objects or an Error.

    func fetchUsers(since: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        let endpoint = "/users"
        let parameters = ["since": since, "per_page": 20]
        api.request(endpoint, parameters: parameters, completion: completion)
    }
    
    /// Fetches detailed information for a specific GitHub user.
    ///
    /// - Parameters:
    ///   - loginUserName: The username of the GitHub user to fetch details for.
    ///   - completion: A closure that is called with the result of the API request.
    ///                 It receives either a UserDetail object or an Error.
    func fetchUserDetail(loginUserName: String, completion: @escaping (Result<UserDetail, Error>) -> Void) {
        let endpoint = "/users/\(loginUserName)"
        api.request(endpoint, completion: completion)
    }
}
