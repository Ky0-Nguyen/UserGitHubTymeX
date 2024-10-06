//
//  UserDetailView.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import SwiftUI

/// UserDetailView displays detailed information about a GitHub user.
/// It shows the user's avatar, name, location, followers, and following count.
/// The view uses a UserViewModel to fetch and manage the user data.
/// It displays a loading indicator while fetching data and handles potential errors.
/// The layout is responsive and adapts to different screen sizes.
struct UserDetailView: View {
    @ObservedObject var viewModel = UserViewModel()
    let loginUsername: String
    @State private var isLoading = true
    
    private let imageSize: CGFloat = 80
    private let imageColor = Color(red: 224/255, green: 224/255, blue: 224/255)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if isLoading {
                    ProgressView("Loading user details...")
                        .onAppear {
                            viewModel.loadUserDetail(for: loginUsername)
                            isLoading = false
                        }
                } else if let userDetail = viewModel.selectedUserDetail {
                    UserDetailContent(userDetail: userDetail, imageSize: imageSize, imageColor: imageColor)
                }
            }
            .padding()
        }
        .background(Color(.clear))
        .navigationTitle("User Details")
    }
}

/// Displays the detailed content for a GitHub user.
/// This view is responsible for presenting the user's information, including their avatar, name,
/// follower and following counts, and blog link if available.
struct UserDetailContent: View {
    let userDetail: UserDetail
    let imageSize: CGFloat
    let imageColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            UserRow(user: nil, userDetail: userDetail)
            Spacer(minLength: 32)
            HStack(spacing: 20) {
                Spacer()
                StatConent(icon: "person.2.fill", value: userDetail.followers ?? 0, label: "Followers", target: 100)
                Spacer()
                StatConent(icon: "rosette", value: userDetail.following ?? 0, label: "Following", target: 10)
                Spacer()
            }
            
            if let blog = userDetail.blog, !blog.isEmpty {
                Spacer(minLength: 32)
                BlogContent(blog: blog)
            }
        }
    }
}

/// This view fetches and presents comprehensive information about a specific GitHub user,
/// including their avatar, name, bio, location, and blog link if available.
/// It uses a `UserViewModel` to manage the data fetching process.
struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailView(loginUsername: "octocat")
                .environmentObject(UserViewModel())
        }
    }
}

