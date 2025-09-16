//
//  FriendRow.swift
//  Mood
//
//  Created by Damilare on 12/06/2025.
//

import SwiftUI

struct FriendRow: View {
    let name: String
    let avatar: String // asset name
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar from assets
            Image(avatar)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            // Name
            Text(name)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
            
            Spacer()
            
            // Remove button
            Button("Remove") {
                onRemove()
            }
            .font(.system(size: 14, weight: .medium, design: .rounded))
            .foregroundColor(.pink)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.pink.opacity(0.1))
            .clipShape(Capsule())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    FriendRow(name: "Helen", avatar: "avatar") {
        // Preview remove action
    }
}
