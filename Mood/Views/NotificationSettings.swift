//
//  NotificationSettings.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

struct NotificationOption: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

struct NotificationSettings: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedOptions: Set<String> = ["daily"]
    @State private var showingSaveAlert = false
    
    let pushNotificationOptions = [
        NotificationOption(
            title: "Daily Reminders",
            subtitle: "Get reminded to log your mood once a day"
        ),
        NotificationOption(
            title: "Weekly Summary",
            subtitle: "Receive a weekly overview of your mood patterns"
        ),
        NotificationOption(
            title: "Friends Activity",
            subtitle: "Get notified when friends share their moods"
        )
    ]
    
    let emailOptions = [
        NotificationOption(
            title: "Mood Insights",
            subtitle: "Get insights about your mood patterns and trends"
        ),
        NotificationOption(
            title: "Weekly Reports",
            subtitle: "Receive detailed weekly mood analysis via email"
        ),
        NotificationOption(
            title: "Monthly Newsletter",
            subtitle: "Stay updated with mood tracking tips and features"
        )
    ]
    
    // UserDefaults keys
    private let notificationKey = "notificationPreferences"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notifications")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("Choose how you want to receive notifications")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Push Notifications Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Push Notifications")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        ForEach(pushNotificationOptions) { option in
                            let optionKey = option.title.lowercased().replacingOccurrences(of: " ", with: "")
                            Toggle(isOn: Binding(
                                get: { selectedOptions.contains(optionKey) },
                                set: { isOn in
                                    if isOn {
                                        selectedOptions.insert(optionKey)
                                    } else {
                                        selectedOptions.remove(optionKey)
                                    }
                                    saveNotificationPreference()
                                }
                            )) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(option.title)
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.primary)
                                    Text(option.subtitle)
                                        .font(.system(size: 14, weight: .regular, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                            }
                            .tint(.green)
                            .padding(.trailing, 20)
                            .padding(.vertical, 12)
                            .background(Color(.systemBackground))
                            if option.id != pushNotificationOptions.last?.id {
                                Divider()
                                    .padding(.leading, 20)
                            }
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
                
                // Emails Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Emails")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        ForEach(emailOptions) { option in
                            let optionKey = option.title.lowercased().replacingOccurrences(of: " ", with: "")
                            Toggle(isOn: Binding(
                                get: { selectedOptions.contains(optionKey) },
                                set: { isOn in
                                    if isOn {
                                        selectedOptions.insert(optionKey)
                                    } else {
                                        selectedOptions.remove(optionKey)
                                    }
                                    saveNotificationPreference()
                                }
                            )) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(option.title)
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.primary)
                                    Text(option.subtitle)
                                        .font(.system(size: 14, weight: .regular, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                            }
                            .tint(.green)
                            .padding(.trailing, 20)
                            .padding(.vertical, 12)
                            .background(Color(.systemBackground))
                            if option.id != emailOptions.last?.id {
                                Divider()
                                    .padding(.leading, 20)
                            }
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Save Button
                Button(action: {
                    saveNotificationPreference()
                    showingSaveAlert = true
                }) {
                    Text("Save Changes")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.sad)
                        .cornerRadius(32)
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .background(Color(.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                }
            }
        }
        .background(Color(.systemBackground))
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            loadNotificationPreference()
        }
        .alert("Success", isPresented: $showingSaveAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your notification settings have been updated successfully.")
        }
    }
    
    // Load notification preferences from UserDefaults
    private func loadNotificationPreference() {
        if let savedOptions = UserDefaults.standard.array(forKey: notificationKey) as? [String] {
            selectedOptions = Set(savedOptions)
        } else {
            selectedOptions = ["daily"]
        }
    }
    
    // Save notification preferences to UserDefaults
    private func saveNotificationPreference() {
        UserDefaults.standard.set(Array(selectedOptions), forKey: notificationKey)
    }
}

// Extension to access notification preferences from other views
extension UserDefaults {
    static func getNotificationPreferences() -> [String] {
        return UserDefaults.standard.array(forKey: "notificationPreferences") as? [String] ?? ["daily"]
    }
    
    static func getNotificationPreferenceDisplayName() -> String {
        let preferences = getNotificationPreferences()
        if preferences.isEmpty {
            return "None"
        } else if preferences.count == 1 {
            return getDisplayName(for: preferences[0])
        } else {
            return "\(preferences.count) selected"
        }
    }
    
    private static func getDisplayName(for preference: String) -> String {
        switch preference {
        case "daily":
            return "Daily Reminders"
        case "weeklysummary":
            return "Weekly Summary"
        case "friendsactivity":
            return "Friends Activity"
        case "moodinsights":
            return "Mood Insights"
        case "weeklyreports":
            return "Weekly Reports"
        case "monthlynewsletter":
            return "Monthly Newsletter"
        default:
            return "Daily Reminders"
        }
    }
}

#Preview {
    NotificationSettings()
} 
