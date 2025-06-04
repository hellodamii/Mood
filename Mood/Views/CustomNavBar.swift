import SwiftUI

struct CustomNavBar: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        HStack {
            // Home
            Button(action: { selectedTab = 0 }) {
                ZStack {
                    Circle()
                        .fill(Color.navBG)
                        .frame(width: 40, height: 40)
                    Image("home")
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .opacity(selectedTab == 0 ? 1.0 : 0.5)
                }
            }
            Spacer()
            Button(action: { selectedTab = 1 }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.navBG)
                        .frame(width: 70, height: 52)
                    Image("calender")
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .opacity(selectedTab == 1 ? 1.0 : 0.5)
                }
            }
            Spacer()
            // Mood/Smile
            Button(action: { selectedTab = 2 }) {
                ZStack {
                    Circle()
                        .fill(Color.navBG)
                        .frame(width: 40, height: 40)
                    Image("smile")
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .opacity(selectedTab == 2 ? 1.0 : 0.5)
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.75))
    }
}

#Preview {
    CustomNavBar()
} 
