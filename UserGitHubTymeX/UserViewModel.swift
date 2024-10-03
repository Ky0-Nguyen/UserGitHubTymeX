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
    private var userService = UserService()
    private var since = 0
    
    
    init() {
        loadCachedUsers()
    }
    
    func loadUsers() {
        userService.fetchUsers(since: since) { result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users.append(contentsOf: users)
                    self.since = users.last?.id ?? 0
                    self.cacheUsers(users)
                }
            case .failure(let error):
                print("Error fetching users: \(error)")
            }
            
        }
    }
    
    func loadUserDetail(for loginUserName:String) {
        userService.fetchUserDetail(loginUserName: loginUserName) { result in
                    switch result {
                    case .success(let userDetails):
                        DispatchQueue.main.async {
                            self.selectedUserDetail = userDetails
                            NSLog("Fetching user details: \(userDetails)")
                        }
                        
                    case .failure(let error):
                        print("Error fetching user details: \(error)")
                    }
                }
    }
    
    private func cacheUsers(_ users: [User]) {
           // Code to cache users
    }
       
    private func loadCachedUsers() {
           // Load cached users on the second launch
    }
}
