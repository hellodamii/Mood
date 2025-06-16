import SwiftUI

struct CustomNavBar: View {
    @Binding var showCalendar: Bool

    var body: some View {
        HStack {
            // Home
            Button(action: { /* Home action */ }) {
                ZStack {
                    Circle()
                        .fill(Color.navBG)
                        .frame(width: 32, height: 32)
                    Image("home")
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .opacity(1.0)
                }
            }
            Spacer()
            Button(action: { showCalendar = true }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.navBG)
                        .frame(width: 54, height: 38)
                    Image("calender")
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                }
            }
            Spacer()
            // Mood/Smile
            Button(action: { /* Mood action */ }) {
                ZStack {
                    Circle()
                        .fill(Color.navBG)
                        .frame(width: 32, height: 32)
                    Image("smile")
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .opacity(0.5)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
        .background(Color.white.opacity(0.5))
    }
}

#Preview {
    CustomNavBar(showCalendar: .constant(false))
} 
