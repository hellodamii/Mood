//
//  ContentView.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate: Date = Date()
    @State private var selectedMoodIndex: Int = 1
    let moodColors: [Color] = [
        .happy, // Happy
        .calm, // Calm
        .neutral, // Neutral
        .sad, // Sad
        .anxious, // Anxious
        .angry, // Angry
        .excited, // Excited
        .frustrated // Frustrated (Brown)
    ]
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
    var body: some View {
        ZStack {
            Color(moodBGNames[selectedMoodIndex])
                .ignoresSafeArea()
            VStack(spacing: 32) {
                VStack(spacing: 16){
                    TopBar()
                    DateBar(selectedDate: $selectedDate)
                }
                MoodView(selectedIndex: $selectedMoodIndex, moodColors: moodColors)
                ModalOne(moodColor: moodColors[selectedMoodIndex])
                Spacer()
            }
            .padding(.horizontal)
            VStack {
                Spacer()
                CustomNavBar()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
