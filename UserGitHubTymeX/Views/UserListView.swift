//
//  UserListView.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(loginUsername: user.login)) {
                            UserRow(user: user, userDetail: nil)
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGroupedBackground))
           

            .onAppear(){
                viewModel.loadUsers()
            }
            .navigationTitle("Github Users")
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
