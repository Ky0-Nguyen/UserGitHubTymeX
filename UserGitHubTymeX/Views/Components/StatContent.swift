//
//  StatContent.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 06/10/2024.
//
import SwiftUI

/// Displays a statistic for a user, such as follower or following count.
/// This view presents an icon, a numeric value, and a label in a visually appealing format.
struct StatConent: View {
    let icon: String
    let value: Int
    let label: String
    let target: Int
    let imageSize: CGFloat = 80
    let imageColor: Color = Color(red: 224/255, green: 224/255, blue: 224/255)
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: imageSize, height: imageSize)
                .background(imageColor)
                .clipShape(Circle())
            
            Text(value > target ? "\(target)+" : "\(value)")
                .font(.headline)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .frame(width: 100)
        }
        .padding()
        .cornerRadius(imageSize/2)
        .shadow(radius: imageSize/2)
        .frame(width: imageSize, height: imageSize)
    }
}
