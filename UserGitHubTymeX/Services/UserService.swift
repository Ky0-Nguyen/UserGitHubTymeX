//
//  UserService.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import Foundation
class UserService {
    private let baseUrl = "https://api.github.com"
    func fetchUsers (since: Int, completion: @escaping (Result<[User], Error>)-> Void) {
        guard let url = URL(string: "\(baseUrl)/users?since=\(since)&per_page=20") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let data = data {
                let decoder  = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchUserDetail(loginUserName:String , completion:  @escaping (Result<UserDetail, Error>) -> Void){
        guard let url = URL(string: "\(baseUrl)/users/\(loginUserName)") else { return }
        NSLog("Fetching user details: \(url)")
        var request = URLRequest(url: url)
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let userDetails = try decoder.decode(UserDetail.self, from: data)
                            completion(.success(userDetails))
                        } catch {
                            completion(.failure(error))
                        }
                    } else if let error = error {
                        completion(.failure(error))
                    }
                }.resume()
    }
}
