//
//  profiles.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

struct profiles: View {
    var name: String
    var body: some View {
        VStack(spacing: 4){
            Image("avatar")
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .clipShape(Circle())
            Text(String(name.prefix(5)) + (name.count > 5 ? "..." : ""))
                .opacity(0.5)
                .font(.system(size: 12,
                              weight: .medium,
                              design: .rounded))
        }
    }
}

#Preview {
    profiles(name: "Jenniva")
}
