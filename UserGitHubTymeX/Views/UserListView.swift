//
//  UserListView.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import SwiftUI

/// Displays a list of GitHub users.
///
/// This view presents a scrollable list of GitHub users. It uses a `UserViewModel`
/// to manage the data and load users as needed. Each user is represented by a `UserRow`
/// and can be tapped to navigate to a detailed view of that user.
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
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                    
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollViewPositionKey.self,
                                        value: geometry.frame(in: .global).maxY)
                    }
                    .frame(height: 20)
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .onAppear {
                if viewModel.users.isEmpty {
                    viewModel.loadUsers()
                }
            }
            .onPreferenceChange(ScrollViewPositionKey.self) { position in
                if position < UIScreen.main.bounds.height && !viewModel.isLoading {
                    viewModel.loadUsers(loadMore: true)
                }
            }
            .navigationTitle("Github Users")
        }
    }
}

struct ScrollViewPositionKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

/// A preview provider for UserListView.
///
/// This struct conforms to the PreviewProvider protocol, allowing Xcode to generate
/// previews of the UserListView in the Canvas. It creates an instance of UserListView
/// that can be used to visualize the layout and design of the view during development.
///
/// Previews are essential for rapid UI development and testing, as they allow
/// developers to see changes in real-time without having to run the full application.
struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
