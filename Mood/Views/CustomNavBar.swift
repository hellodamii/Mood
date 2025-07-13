import SwiftUI

enum Tabs {
    case mood, history, profile
}

struct CustomNavBar: View {
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
            
            Tab("Profile", systemImage: "person", value: .profile) {
               //
            }
        }
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
            .presentationDetents([.large])
        }
        
       
    }
}

#Preview {
    CustomNavBar()
} 
