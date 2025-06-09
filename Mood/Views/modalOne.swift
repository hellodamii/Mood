//
//  modalOne.swift
//  Mood
//
//  Created by Busha on 04/06/2025.
//

import SwiftUI

struct ModalOne: View {
    @State private var comment: String = ""
    var moodColor: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("What contributed to this feeling?")
                .font(.system(size: 16, weight: .medium, design: .rounded))

            TextField("Add a comment...", text: $comment)
                .font(.system(size: 12))
                .frame(height: 36)
                .padding(.horizontal)
                .background(Color(moodColor.opacity(0.05)))
                .cornerRadius(24)
                .overlay(
                    HStack {
                        Spacer()
                        Text("(optional)")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                            .padding(.trailing, 16)
                    }
                )
            
            HStack(alignment: .top, spacing: 8) {
                profiles(name: "Helen")
                profiles(name: "Ifeakachukwu")
                profiles(name: "Jenniva")
                // Plus icon
                ZStack {
                    Circle()
                        .fill(Color(.systemGray6))
                        .frame(width: 28, height: 26)
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .medium))
                }
                Spacer()
                // Share mood button
                Button(action: {}) {
                    Text("Share mood")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(moodColor)
                        .frame(width: 90, height: 28)
                        .background(moodColor.opacity(0.1))
                        .clipShape(Capsule())
                }
            }
           
        }
        .padding()
        .background(Color.white)
        .cornerRadius(32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color(.modalBorder), lineWidth: 1)
        )
    }
}

#Preview {
    ModalOne(moodColor: .green)
}
