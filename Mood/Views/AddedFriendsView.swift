//
//  AddedFriendsView.swift
//  Mood
//
//  Created by Damilare on 12/06/2025.
//

import SwiftUI

struct AddedFriendsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Add friends")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .padding(.top, 20)
                .padding(.bottom, 24)
            
            // Added Friends Section
            VStack(alignment: .leading, spacing: 0) {
                Text("Added Friends")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                // Friend List
                VStack(spacing: 0) {
                    FriendRow(name: "Helen", avatar: "avatar") {
                        // Remove action
                    }
                    Divider()
                        .padding(.horizontal, 20)
                    FriendRow(name: "Tobechukwu", avatar: "avatar") {
                        // Remove action
                    }
                    Divider()
                        .padding(.horizontal, 20)
                    FriendRow(name: "Kenechukwu", avatar: "avatar") {
                        // Remove action
                    }
                }
            }
            
            Spacer()
            
            // Add new friends button
            NavigationLink(destination: FriendsListView()) {
                Text("Add new friends")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
    }
}

#Preview {
    AddedFriendsView()
}
