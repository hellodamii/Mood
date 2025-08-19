//
//  ContentView.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI
import UIKit


struct ContentView: View {
	@State private var selectedDate: Date = Date()
	@State private var selectedMoodIndex: Int = 1
	@State private var showCalendar: Bool = false
	@State private var isKeyboardVisible: Bool = false
	@Environment(\.colorScheme) private var colorScheme
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
			// Dynamic gradient background based on selected mood color and color scheme
			LinearGradient(
				gradient: Gradient(colors: [
					moodColors[selectedMoodIndex].opacity(colorScheme == .dark ? 0.4 : 0.2),
					moodColors[selectedMoodIndex].opacity(colorScheme == .dark ? 0.2 : 0.1),
					Color(.systemBackground).opacity(colorScheme == .dark ? 0.9 : 0.95)
				]),
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)
			.ignoresSafeArea()
			
			VStack(spacing: 18) {
				VStack(spacing: 18){
					TopBar()
					DateBar(selectedDate: $selectedDate)
				}
				MoodView(selectedIndex: $selectedMoodIndex, moodColors: moodColors)
				ModalOne(moodColor: moodColors[selectedMoodIndex], isKeyboardVisible: isKeyboardVisible)
			
			}
			.padding(.horizontal)
			.keyboardAdaptive()
			.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)) { note in
				guard let info = note.userInfo,
					  let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
				let screenHeight = UIScreen.main.bounds.height
				isKeyboardVisible = endFrame.origin.y < screenHeight
			}
			.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
				isKeyboardVisible = false
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

#Preview {
	ContentView()
}


