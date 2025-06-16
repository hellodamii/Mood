//
//  HistoryView.swift
//  Mood
//
//  Created by Damilare on 12/06/2025.
//

import SwiftUI

struct MoodDay: Identifiable {
    let id = UUID()
    let date: Date
    let color: Color
}

struct HistoryView: View {
    var chevronColor: Color
    @State private var selectedDate: Date = Date()
    // Example mood data for demonstration
    let moodDays: [MoodDay] = [
        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 9))!, color: .mint),
        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 10))!, color: .blue),
        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 11))!, color: .pink),
        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 13))!, color: .pink),
        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 14))!, color: .blue),
        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 15))!, color: .blue),
        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 16))!, color: .pink)
//        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 17))!, color: .yellow),
//        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 18))!, color: .pink),
//        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 19))!, color: .green),
//        MoodDay(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 20))!, color: .pink)
    ]
    
    private var daysInMonth: [Date] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: selectedDate)
        let startOfMonth = calendar.date(from: components)!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        return range.compactMap { day -> Date? in
            calendar.date(from: DateComponents(year: components.year, month: components.month, day: day))
        }
    }
    
    private var firstWeekday: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: selectedDate)
        let startOfMonth = calendar.date(from: components)!
        return calendar.component(.weekday, from: startOfMonth)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Month and year header
            HStack {
                Text(selectedDate, formatter: DateFormatter.monthAndYear)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                Spacer()
                HStack(spacing: 8) {
                    Button(action: {
                        // Go to previous month
                        if let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) {
                            selectedDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: prevMonth)) ?? selectedDate
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(chevronColor)
                    }
                    Button(action: {
                        // Go to next month
                        if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) {
                            selectedDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: nextMonth)) ?? selectedDate
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(chevronColor)
                    }
                }
            }
            // Days of week
            HStack {
                ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \ .self) { day in
                    Text(day)
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary.opacity(0.5))
                }
            }
            // Calendar grid
            let days = daysInMonth
            let leadingSpaces = Array(repeating: Date.distantPast, count: firstWeekday - 1)
            let allDays = leadingSpaces + days
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                ForEach(allDays.indices, id: \ .self) { idx in
                    let date = allDays[idx]
                    VStack(spacing: -2) {
                        if date == Date.distantPast {
                            Text("")
                                .frame(height: 20)
                        } else {
                            Text("\(Calendar.current.component(.day, from: date))")
                                .font(.system(size: 20, weight: Calendar.current.isDate(date, inSameDayAs: selectedDate) ? .bold : .regular, design: .rounded))
                                .foregroundColor(Calendar.current.isDate(date, inSameDayAs: selectedDate) ? chevronColor : .primary)
                                .opacity((Calendar.current.isDateInToday(date) || Calendar.current.isDate(date, inSameDayAs: selectedDate)) ? 1.0 : 0.6)
                                .frame(width: 28, height: 28)
                            // Circle indicator
                            if let mood = moodDays.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                                Circle()
                                    .fill(mood.color)
                                    .frame(width: 5, height: 5)
                            } else {
                                Spacer().frame(height: 4)
                            }
                        }
                    }
                    .onTapGesture {
                        if date != Date.distantPast {
                            selectedDate = date
                        }
                    }
                }
            }
            //Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(28)
        .padding()
    }
}

extension DateFormatter {
    static let monthAndYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
}

#Preview {
    HistoryView(chevronColor: .pink)
}
