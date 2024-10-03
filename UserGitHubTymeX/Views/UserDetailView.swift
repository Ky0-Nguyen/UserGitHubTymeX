//
//  UserDetailView.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var viewModel = UserViewModel()

    let loginUsername: String
    @State private var isLoading = true
    private var imageSize: CGFloat {
        100
    }
    
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
                    VStack(alignment: .leading, spacing: 10) {
                            UserRow(user: nil, userDetail: userDetail)
                        Spacer()
                        HStack(spacing: 20) {
                                Spacer()
                                VStack {
                                    Image(systemName: "person.2")
                                        .font(.system(size: 24))
                                    Text("\(userDetail.followers ?? 0)")
                                        .font(.headline)
                                    Text("Followers")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(imageSize/2)
                                .shadow(radius: 50)
                                .frame(width: imageSize, height: imageSize)
                                Spacer()
                                VStack {
                                    Image(systemName: "person.2.fill")
                                        .font(.system(size: 24))
                                    Text("\(userDetail.following ?? 0)")
                                        .font(.headline)
                                    Text("Following")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(imageSize/2)
                                .shadow(radius: 50)
                                .frame(width: imageSize, height: imageSize)
                                Spacer()
                            }
            
                        
                    
            
                    if let blog = userDetail.blog, !blog.isEmpty {
                        Spacer()
                        Spacer()
                        Link(destination: URL(string: blog) ?? URL(string: "https://github.com")!) {
                            HStack {
                                Image(systemName: "link")
                                Text("Blog")
                                Spacer()
                                Image(systemName: "arrow.up.right.square")
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                        Link(destination: URL(string: blog) ?? URL(string: "https://github.com")!) {
                            HStack {
                                Image(systemName: "link")
                                Text("Social")
                                Spacer()
                                Image(systemName: "arrow.up.right.square")
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }}
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("User Details")
    }
}

