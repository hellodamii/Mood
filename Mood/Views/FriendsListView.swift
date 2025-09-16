//
//  FriendsListView.swift
//  Mood
//
//  Created by Damilare on 12/06/2025.
//

import SwiftUI

struct FriendsListView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Add friends")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .padding(.top, 20)
                .padding(.bottom, 24)
            
            // Friends Section
            VStack(alignment: .leading, spacing: 0) {
                Text("Friends")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                // Friends List
                VStack(spacing: 0) {
                    FriendAddRow(name: "Jenniva", avatar: "avatar") {
                        // Add action
                    }
                    Divider()
                        .padding(.horizontal, 20)
                    FriendAddRow(name: "Samuel", avatar: "avatar") {
                        // Add action
                    }
                    Divider()
                        .padding(.horizontal, 20)
                    FriendAddRow(name: "Joshua", avatar: "avatar") {
                        // Add action
                    }
                }
            }
            
            Spacer()
            
            // Invite friends button
            Button("Invite friends") {
                // Invite friends action
            }
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FriendsListView()
}
