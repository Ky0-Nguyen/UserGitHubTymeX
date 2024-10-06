//
//  BlogContent.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 06/10/2024.
//

import SwiftUI

/// Displays the user's blog link if available.
/// This view presents the blog URL as a tappable link that opens in the default web browser.
struct BlogContent: View {
    let blog: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Blog")
                .font(.headline)
            Link(destination: URL(string: blog)!) {
                HStack {
                    Text(blog)
                        .foregroundColor(.blue)
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "safari")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
