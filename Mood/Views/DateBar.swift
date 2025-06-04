//
//  DateBar.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

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
        GeometryReader { geometry in
            HStack(spacing: 24) {
                ForEach(weekDates, id: \.self) { date in
                    let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                    VStack(alignment: .center, spacing: 4) {
                        Text(dayFormatter.string(from: date).prefix(1))
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.black.opacity(0.5))
                        Text(dateFormatter.string(from: date))
                            .font(.system(size: isSelected ? 22 : 18, weight: .heavy, design: .rounded))
                            .foregroundColor(isSelected ? Color.black : Color.black.opacity(0.5))
                        if date <= Date() {
                            Circle()
                                .fill(Color(.pink))
                                .frame(width: 4, height: 4)
                        } else {
                            Spacer().frame(height: 4)
                        }
                    }
                    .onTapGesture {
                        selectedDate = date
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                }
            }
            .frame(width: geometry.size.width)
            
        }
        .frame(height: 60)
    }
}

struct PreviewWrapper: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        DateBar(selectedDate: $selectedDate)
    }
}

#Preview {
    PreviewWrapper()
}
