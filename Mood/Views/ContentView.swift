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
    @State private var showCalendar: Bool = false
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
            
            VStack(spacing: 24) {
                
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
                CustomNavBar(showCalendar: $showCalendar)
            }
            
            // Floating sheet overlay
            if showCalendar {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showCalendar = false
                    }
                VStack {
                    Spacer()
                    HistoryView(chevronColor: moodColors[selectedMoodIndex])
                        .padding(.bottom, 16)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
               .ignoresSafeArea(.keyboard)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
