//
//  UserRow.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import SwiftUI

struct UserRow: View {
    let user: User?
    let userDetail: UserDetail?
    
    @State private var isExpanded = false
    
    private var cardBackgroundColor: Color {
        Color(red: 0.95, green: 0.95, blue: 0.97)
    }
    
    private var avatarSize: CGFloat {
        150
    }

    var body: some View {
        HStack(alignment: .top) {
                if let avatarUrl = user?.avatar_url ?? userDetail?.avatar_url  {
                    AsyncImage(url: URL(string: avatarUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    if let userName = user?.login ?? userDetail?.login ?? "" {
                        Text(userName)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    Divider()
                    if(user != nil) {
                        Text("https://github.com/\(user?.login ?? " ")")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    
                    if(userDetail != nil) {
                        HStack () {
                             Image(systemName: "mappin.and.ellipse")
                        Text(userDetail?.location ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        }
                       
                    }
                  
                }
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
