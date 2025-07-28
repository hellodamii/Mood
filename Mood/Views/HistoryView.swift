//
//  HistoryView.swift
//  Mood
//
//  Created by Damilare on 12/06/2025.
//

import SwiftUI


struct HistoryView: View {
    @State private var selectedDate: Date = Date()
    @State private var moodTab = 0
    @State var sheetPresented = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Moods")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
            
            DateBar(selectedDate: $selectedDate)
            
            Picker("Pick segment", selection: $moodTab) {
                Text("Received").tag(0)
                Text("Sent").tag(1)
            }
            .pickerStyle(.segmented)
            
            FriendsMoodListView(entries: [
                FriendMood(name: "Helen", avatar: "avatar", mood: "happy", comment: nil, commentColor: nil, timeAgo: "12mins ago")
            ])

                                
        }
        .padding(.horizontal)
    }
    }


#Preview {
    HistoryView()
}
