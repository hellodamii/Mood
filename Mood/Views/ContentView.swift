//
//  ContentView.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate: Date = Date()
    var body: some View {
        VStack {
            DateBar(selectedDate: $selectedDate)
        }
        .padding()
    }
}

struct DateBar: View {
    @Binding var selectedDate: Date
    
    private var weekDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        // Get the start of the week (Sunday)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: calendar.startOfDay(for: today))!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // Short day (Sun, Mon, ...)
        return formatter
    }
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d" // Day number
        return formatter
    }
    
    var body: some View {
        HStack(spacing: 24) {
            ForEach(weekDates, id: \.self) { date in
                let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                VStack(spacing: 4) {
                    Text(dayFormatter.string(from: date).prefix(1))
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(dateFormatter.string(from: date))
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundColor(isSelected ? Color.pink : Color.primary)
                        .background(
                            isSelected ? Circle().fill(Color.pink.opacity(0.15)).frame(width: 32, height: 32) : nil
                        )
                }
                .opacity(isSelected ? 1.0 : 0.5)
                .onTapGesture {
                    selectedDate = date
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
