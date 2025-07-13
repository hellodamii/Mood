import SwiftUI

struct FriendMood: Identifiable {
    let id = UUID()
    let name: String
    let avatar: String // image asset name
    let mood: String
    let comment: String?
    let commentColor: Color?
    let timeAgo: String
}

struct FriendMoodRow: View {
    let entry: FriendMood
    var body: some View {
        VStack(alignment: .leading, spacing: entry.comment == nil ? 0 : 6) {
            HStack(alignment: .center, spacing: 14) {
                Image(entry.avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                HStack(spacing: 0) {
                    Text(entry.name)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Text(" is feeling ")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                    Text(entry.mood)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
                Text(entry.timeAgo)
                    .font(.system(size: 8, weight: .medium, design: .rounded))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .foregroundColor(.black.opacity(0.5))
                    .background(Color.white)
                    .clipShape(Capsule())
            }
            .padding()
        }
        .padding(.vertical, 8)
    }
}

struct FriendsMoodListView: View {
    let entries: [FriendMood]
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            Text("20-05-2025")
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(.black.opacity(0.5))
            HStack {
                ForEach(entries) { entry in
                    FriendMoodRow(entry: entry)
                }
            }
            .background(Color(.secondarySystemBackground))
            .cornerRadius(18)
        }
    }
}

#Preview {
    FriendsMoodListView(entries: [
        FriendMood(name: "Helen", avatar: "avatar", mood: "happy", comment: nil, commentColor: nil, timeAgo: "12mins ago")
    ])
} 
