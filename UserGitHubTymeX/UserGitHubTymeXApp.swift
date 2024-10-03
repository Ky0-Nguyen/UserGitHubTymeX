//
//  UserGitHubTymeXApp.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 02/10/2024.
//

import SwiftUI
//
//@main
//struct UserGitHubTymeXApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}

@main
struct UserGitHubTymeXApp: App{
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}
