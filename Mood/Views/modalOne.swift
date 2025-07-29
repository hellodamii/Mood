//
//  modalOne.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

struct ModalOne: View {
    
    let moodBGNames = [
        "happyBG",      // Happy
        "calmBG",       // Calm
        "neutralBG",    // Neutral
        "sadBG",        // Sad
        "anxiousBG",    // Anxious
        "angryBG",      // Angry
        "excitedBG",    // Excited
        "frustratedBG"  // Frustrated
    ]
    @State private var comment: String = ""
    @State private var selectedMoodIndex: Int = 1
    var moodColor: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What contributed to this feeling?")
                .font(.system(size: 16, weight: .medium, design: .rounded))

            TextField("Add a comment...", text: $comment)
                .font(.system(size: 12))
                .frame(height: 40)
                .padding(.horizontal)
                .background(.secondary.opacity(0.2))
                .cornerRadius(24)
                .overlay(
                    HStack {
                        Spacer()
                        Text("(optional)")
                            .foregroundColor(.secondary)
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
                        .fill(.secondary.opacity(0.2))
                        .frame(width: 28, height: 28)
                    Image(systemName: "plus")
                        .foregroundColor(.secondary)
                        .font(.system(size: 12, weight: .medium))
                }
                Spacer()
                // Share mood button
                Button(action: {}) {
                    Text("Share mood")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(moodColor)
                        .frame(width: 90, height: 32)
                        .background(moodColor.opacity(0.3))
                        .clipShape(Capsule())
                }
            }
           
        }
        .padding()
        .background(Color(moodBGNames[selectedMoodIndex]))
        .cornerRadius(32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color(.separator), lineWidth: 1)
        )
    }
}

#Preview {
    ModalOne(moodColor: .green)
}
