//
//  UserDetail.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import Foundation
struct UserDetail: Codable, Identifiable {
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String?
    let location: String?
    let followers: Int?
    let following: Int?
    let blog: String?
}
