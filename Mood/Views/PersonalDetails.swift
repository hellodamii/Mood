//
//  PersonalDetails.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

struct PersonalDetails: View {
    @Environment(\.dismiss) private var dismiss
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var showingSaveAlert = false
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    // UserDefaults keys
    private let firstNameKey = "userFirstName"
    private let lastNameKey = "userLastName"
    private let emailKey = "userEmail"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Personal Details")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("Update your personal information")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Form fields
                VStack(spacing: 20) {
                    // First Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("First Name")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.primary)
                        
                        TextField("Enter your first name", text: $firstName)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .padding()
                            .background(Color(.systemGray6).opacity(0.5))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.separator), lineWidth: 1)
                            )
                    }
                    
                    // Last Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Last Name")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.primary)
                        
                        TextField("Enter your last name", text: $lastName)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .padding()
                            .background(Color(.systemGray6).opacity(0.5))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.separator), lineWidth: 1)
                            )
                    }
                    
                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                        
                        TextField("Enter your email", text: $email)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .disabled(true)
                            .foregroundColor(.secondary)
                            .padding()
                            .background(Color(.systemGray6).opacity(0.5))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Save Button
                Button(action: saveUserData) {
                    Text("Save Changes")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(isFormValid ? Color.sad : Color.gray)
                        .cornerRadius(32)
                }
                .disabled(!isFormValid)
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
            loadUserData()
        }
        .alert("Success", isPresented: $showingSaveAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your personal details have been saved successfully.")
        }
        .alert("Error", isPresented: $showingErrorAlert) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    // Computed property to check if form is valid
    private var isFormValid: Bool {
        !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // Email validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Load user data from UserDefaults
    private func loadUserData() {
        let defaults = UserDefaults.standard
        firstName = defaults.string(forKey: firstNameKey) ?? ""
        lastName = defaults.string(forKey: lastNameKey) ?? ""
        email = defaults.string(forKey: emailKey) ?? ""
    }
    
    // Save user data to UserDefaults
    private func saveUserData() {
        let defaults = UserDefaults.standard
        
        // Trim whitespace from inputs
        let trimmedFirstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validate inputs
        guard !trimmedFirstName.isEmpty else {
            errorMessage = "First name cannot be empty"
            showingErrorAlert = true
            return
        }
        
        guard !trimmedLastName.isEmpty else {
            errorMessage = "Last name cannot be empty"
            showingErrorAlert = true
            return
        }
        

        
        // Save to UserDefaults
        defaults.set(trimmedFirstName, forKey: firstNameKey)
        defaults.set(trimmedLastName, forKey: lastNameKey)
        defaults.set(trimmedEmail, forKey: emailKey)
        
        // Show success alert
        showingSaveAlert = true
    }
}

// Extension to access user data from other views
extension UserDefaults {
    static func getUserFirstName() -> String {
        return UserDefaults.standard.string(forKey: "userFirstName") ?? ""
    }
    
    static func getUserLastName() -> String {
        return UserDefaults.standard.string(forKey: "userLastName") ?? ""
    }
    
    static func getUserEmail() -> String {
        return UserDefaults.standard.string(forKey: "userEmail") ?? ""
    }
    
    static func getUserFullName() -> String {
        let firstName = getUserFirstName()
        let lastName = getUserLastName()
        if firstName.isEmpty && lastName.isEmpty {
            return "User"
        }
        return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
    }
}

#Preview {
    PersonalDetails()
} 
