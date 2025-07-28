import SwiftUI

struct MoodView: View {
    @Binding var selectedIndex: Int
    let moodColors: [Color]
    let moods = ["Happy", "Calm", "Neutral", "Sad", "Anxious", "Angry", "Excited", "Frustrated"]
    let itemWidth: CGFloat = 260
    let spacing: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var baseOffset: CGFloat = 0
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
                    ForEach(0..<moods.count, id: \.self) { idx in
                        ZStack {
                            VStack {
                                Image(moodImages[idx])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 260, height: 260)
                            }
                        }
                        .scaleEffect(idx == selectedIndex ? 1.1 : 0.9)
                        .opacity(idx == selectedIndex ? 1.0 : (abs(idx - selectedIndex) == 1 ? 0.5 : 0.5))
                        .onTapGesture {
                            if idx != selectedIndex {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                            }
                            withAnimation(.easeInOut(duration: 0.25)) {
                                selectedIndex = idx
                                baseOffset = geo.size.width / 2 - itemWidth / 2 - CGFloat(selectedIndex) * (itemWidth + spacing)
                            }
                        }
                    }
                }
                .offset(x: baseOffset + dragOffset)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation.width
                        }
                        .onEnded { value in
                            let drag = value.translation.width
                            let threshold: CGFloat = 40
                            var newIndex = selectedIndex
                            if drag < -threshold && selectedIndex < moods.count - 1 {
                                newIndex += 1
                            } else if drag > threshold && selectedIndex > 0 {
                                newIndex -= 1
                            }
                            if newIndex != selectedIndex {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                            }
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedIndex = newIndex
                                baseOffset = geo.size.width / 2 - itemWidth / 2 - CGFloat(selectedIndex) * (itemWidth + spacing)
                            }
                        }
                )
                .onAppear {
                    baseOffset = geo.size.width / 2 - itemWidth / 2 - CGFloat(selectedIndex) * (itemWidth + spacing)
                }
                .onChange(of: selectedIndex) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        baseOffset = geo.size.width / 2 - itemWidth / 2 - CGFloat(selectedIndex) * (itemWidth + spacing)
                    }
                }
            }
            .frame(height: itemWidth + 8)
            Text("Swipe to select")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(.primary.opacity(0.6))
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
