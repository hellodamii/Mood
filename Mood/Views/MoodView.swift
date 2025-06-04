import SwiftUI

struct MoodView: View {
    @Binding var selectedIndex: Int
    let moodColors: [Color]
    let moods = ["Happy", "Calm", "Neutral", "Sad", "Anxious", "Angry", "Excited", "Frustrated"]
    let itemWidth: CGFloat = 260
    let spacing: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    let moodImages = [
        "Happy",      // Happy
        "calm",       // Calm
        "neutral",    // Neutral
        "sad",        // Sad
        "anxious",    // Anxious
        "angry",      // Angry
        "excited",    // Excited
        "frustrated"  // Frustrated
    ]

    var body: some View {
        VStack(spacing: 8) {
            Text("Currently, I feel")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(moodColors[selectedIndex])
            Text(moods[selectedIndex])
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundColor(moodColors[selectedIndex])
                .id("mood_\(selectedIndex)")
                .transition(.opacity.combined(with: .scale))
                .animation(.easeInOut(duration: 0.3), value: selectedIndex)
            GeometryReader { geo in
                HStack(spacing: spacing) {
                    ForEach(0..<moods.count, id: \ .self) { idx in
                        ZStack {
                            VStack {
                                Image(moodImages[idx])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 260, height: 260)
                            }
                        }
                        .scaleEffect(idx == selectedIndex ? 1.1 : 0.9)
                        .animation(.spring(), value: selectedIndex)
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = idx
                            }
                        }
                    }
                }
                .offset(x: dragOffset + (geo.size.width / 2 - itemWidth / 2) - CGFloat(selectedIndex) * (itemWidth + spacing))
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation.width
                        }
                        .onEnded { value in
                            let drag = value.translation.width
                            let progress = -drag / (itemWidth + spacing)
                            let newIndex = (CGFloat(selectedIndex) + progress).rounded().clamped(to: 0...(CGFloat(moods.count - 1)))
                            withAnimation {
                                selectedIndex = Int(newIndex)
                            }
                        }
                )
            }
            .frame(height: itemWidth + 16)
            Text("Swipe to select")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(moodColors[selectedIndex].opacity(0.6))
        }
        .frame(maxWidth: .infinity)
    }
}

// Helper to clamp CGFloat
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}

#Preview {
    MoodView(selectedIndex: .constant(1), moodColors: [.pink, .green, .black, .blue, .purple, .red, .orange, .brown])
} 
