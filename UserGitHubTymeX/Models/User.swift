//
//  User.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import Foundation

/// Represents a GitHub user.
struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let avatar_url: String
}
