//
//  TopBar.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text("mood")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                Spacer()
                NavigationLink {
                    ProfileView()
                } label: {
                    Image("avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .accessibilityLabel("Open Profile")
                }
                .buttonStyle(.plain)
            }
            .frame(width: geometry.size.width)
        }
        .frame(height: 32)
    }
}

#Preview {
    NavigationStack {
        TopBar()
    }
}
