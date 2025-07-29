import SwiftUI

struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let showChevron: Bool
    
    init(icon: String, iconColor: Color, title: String, subtitle: String, showChevron: Bool = true) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.showChevron = showChevron
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(iconColor)
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .medium))
            }
            
            // Text content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Chevron
            if showChevron {
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.system(size: 14, weight: .medium))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 2) {
                // Header
                HStack {
                    Text("Damilare")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 24)
                
                // Main settings
                VStack(alignment: .leading, spacing: 0) {
                    Text("Personalize")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    
                    
                    
                    SettingsRow(
                        icon: "person.fill",
                        iconColor: .purple,
                        title: "Personal Details",
                        subtitle: "Edit your name and email"
                    )
                    Divider()
                        .padding(.leading, 76)
                    SettingsRow(
                        icon: "person.2.fill",
                        iconColor: .blue,
                        title: "Friends",
                        subtitle: "Add or remove friends"
                    )
                    
                    Divider()
                        .padding(.leading, 76)
                    
                    SettingsRow(
                        icon: "bell.fill",
                        iconColor: .green,
                        title: "Notifications",
                        subtitle: "Edit how you receive alerts"
                    )
                    
                    
                    
                }
                .background(Color(.systemBackground))
                .cornerRadius(16)
                
                
                // Danger zone
                VStack(alignment: .leading,spacing: 16) {
                    Text("Danger zone")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, 32)
                    
                    VStack(spacing:2){
                        SettingsRow(
                            icon: "rectangle.portrait.and.arrow.right",
                            iconColor: .pink,
                            title: "Sign out",
                            subtitle: "Sign out of the app"
                        )
                        Divider()
                            .padding(.leading, 76)
                        
                        SettingsRow(
                            icon: "trash.fill",
                            iconColor: .red,
                            title: "Delete account",
                            subtitle: "I know your addrss" 
                        )
                    }
                }
                .background(Color(.systemBackground))
                .cornerRadius(16)
                
                Spacer()
                VStack{
                    Text("mood")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary.opacity(0.2))
                    Text("built by an independent developer in Nigeria")
                        .multilineTextAlignment(.center)
                        .frame(width: 160)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(.primary.opacity(0.2))
                   
                }
                .padding(.bottom)
            }
            
           
        }
    }
}

#Preview {
    ProfileView()
} 
