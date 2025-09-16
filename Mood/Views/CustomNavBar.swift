import SwiftUI

enum Tabs {
    case mood, history, profile, friends
}

struct CustomNavBar: View {
    var moodColor: Color
    @State var selectedTab: Tabs = .mood
    @State private var showHistorySheet = false
    @State private var previousTab: Tabs = .mood
    @State private var selectedMoodIndex: Int = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house", value: .mood) {
                ContentView()
            }
        
            Tab("History", systemImage: "calendar", value: .history) {
          HistoryView()
                
            }
            
            Tab("Friends", systemImage: "person.2.fill", value: .friends) {
              
            }
            
            Tab("Profile", systemImage: "person", value: .profile) {
               ProfileView()
            }
        }
        .tint(.primary)
        .onChange(of: selectedTab) {
            if selectedTab == .history {
                showHistorySheet = true
                selectedTab = previousTab // Reset to previous tab
            } else {
                previousTab = selectedTab
            }
        }
        .sheet(isPresented: $showHistorySheet) {
            VStack{
            HistoryView()
            Spacer()
        }
            .padding(.vertical, 32)
            // Remove the opaque background to allow glass
            //.background(Color(.systemBackground))
            .presentationDetents([.large])
            .presentationBackground(.clear) // fully transparent, lets system glass show
            // .presentationBackground(.thinMaterial) // or a material if you prefer
        }
        

        
       
    }
}

#Preview {
    CustomNavBar(moodColor: .green)
} 
