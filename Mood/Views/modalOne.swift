//
//  modalOne.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI

struct Friend: Identifiable {
    let id = UUID()
    let name: String
    let avatar: String
}

private extension Color {
    static var systemSeparator: Color {
        #if os(iOS) || os(tvOS) || os(visionOS)
        return Color(UIColor.separator)
        #elseif os(macOS)
        return Color(NSColor.separatorColor)
        #else
        return .secondary.opacity(0.3)
        #endif
    }
}

struct ModalOne: View {
    
    let moodBGNames = [
        "happyBG",      // Happy
        "calmBG",       // Calm
        "neutralBG",    // Neutral
        "sadBG",        // Sad
        "anxiousBG",    // Anxious
        "angryBG",      // Angry
        "excitedBG",    // Excited
        "frustratedBG"  // Frustrated
    ]
    @State private var comment: String = ""
    @State private var selectedMoodIndex: Int = 1
    @State private var isShowingAddSheet: Bool = false
    @State private var isShowingFriendsSheet: Bool = false
    @State private var isShowingInviteSheet: Bool = false
    @State private var isShared: Bool = false
    @State private var addedFriends: [Friend] = [
        Friend(name: "Helen", avatar: "avatar"),
        Friend(name: "Tobechukwu", avatar: "avatar"),
        Friend(name: "Kenechukwu", avatar: "avatar")
    ]
    @State private var availableFriends: [Friend] = [
        Friend(name: "Jenniva", avatar: "avatar"),
        Friend(name: "Samuel", avatar: "avatar"),
        Friend(name: "Joshua", avatar: "avatar")
    ]
    var moodColor: Color
    var isKeyboardVisible: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What contributed to this feeling?")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)

            TextField("Add a comment...", text: $comment)
                .font(.system(size: 12))
                .frame(height: 40)
                .padding(.horizontal)
                .background(moodColor.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(moodColor.opacity(0.5), lineWidth: 0.2)
                )
                .overlay(
                    HStack {
                        Spacer()
                        Text("(optional)")
                            .foregroundColor(.secondary)
                            .font(.system(size: 10))
                            .padding(.trailing, 16)
                    }
                )
            
            HStack(alignment: .top, spacing: 8) {
                profiles(name: "Helen")
                profiles(name: "Ifeakachukwu")
                profiles(name: "Jenniva")
                // Plus icon as a button
                Button {
                    isShowingAddSheet = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(.secondary.opacity(0.2))
                            .frame(width: 28, height: 28)
                        Image(systemName: "plus")
                            .foregroundColor(.secondary)
                            .font(.system(size: 12, weight: .medium))
                            .accessibilityLabel("Add")
                    }
                }
                .buttonStyle(.plain)
                
                Spacer()
                // Share mood button
                Button(action: {
                    isShared = true
                }) {
                    Text(isShared ? "Shared!" : "Share mood")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(isShared ? .secondary : moodColor)
                        .frame(width: 90, height: 32)
                        .background(isShared ? Color.secondary.opacity(0.2) : moodColor.opacity(0.3))
                        .clipShape(Capsule())
                }
                .disabled(isShared)
            }
           
        }
        .padding()
        .glassEffect(.clear, in: .rect(cornerRadius: 32))
//        .background(Color(moodBGNames[selectedMoodIndex]))
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.systemSeparator, lineWidth: 0.2)
        )
        .sheet(isPresented: $isShowingAddSheet) {
            FirstSheetContent(
                showingSecondSheet: $isShowingFriendsSheet,
                addedFriends: $addedFriends,
                availableFriends: $availableFriends,
                onRemoveFriend: removeFriend,
                onAddFriend: addFriend,
                showingInviteSheet: $isShowingInviteSheet
            )
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(32)
        }
    }
    
    private func removeFriend(at index: Int) {
        let removedFriend = addedFriends[index]
        addedFriends.remove(at: index)
        // Add back to available friends
        availableFriends.append(removedFriend)
    }
    
    private func addFriend(_ friend: Friend) {
        addedFriends.append(friend)
        // Remove from available friends
        availableFriends.removeAll { $0.id == friend.id }
    }
}

struct FirstSheetContent: View {
    @Binding var showingSecondSheet: Bool
    @Binding var addedFriends: [Friend]
    @Binding var availableFriends: [Friend]
    let onRemoveFriend: (Int) -> Void
    let onAddFriend: (Friend) -> Void
    @Binding var showingInviteSheet: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Add friends")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .padding(.top, 20)
                .padding(.bottom, 24)
            
            // Added Friends Section
            VStack(alignment: .leading, spacing: 0) {
                Text("Added Friends")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                // Scrollable Friend List
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(addedFriends.enumerated()), id: \.element.id) { index, friend in
                            FriendRow(name: friend.name, avatar: friend.avatar) {
                                onRemoveFriend(index)
                            }
                            if index < addedFriends.count - 1 {
                                Divider()
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            // Add new friends button
            Button("Add new friends") {
                showingSecondSheet = true
            }
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
        .sheet(isPresented: $showingSecondSheet) {
            SecondSheetContent(
                availableFriends: $availableFriends, 
                onAddFriend: onAddFriend,
                showingInviteSheet: $showingInviteSheet
            )
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(20)
        }
    }
}

struct SecondSheetContent: View {
    @Binding var availableFriends: [Friend]
    let onAddFriend: (Friend) -> Void
    @Binding var showingInviteSheet: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Add friends")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .padding(.top, 20)
                .padding(.bottom, 24)
            
            // Friends Section
            VStack(alignment: .leading, spacing: 0) {
                Text("Friends")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                // Scrollable Friends List
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(availableFriends.enumerated()), id: \.element.id) { index, friend in
                            FriendAddRow(name: friend.name, avatar: friend.avatar) {
                                onAddFriend(friend)
                            }
                            if index < availableFriends.count - 1 {
                                Divider()
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            // Invite friends button
            Button("Invite friends") {
                showingInviteSheet = true
            }
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
        .sheet(isPresented: $showingInviteSheet) {
            InviteFriendsSheet()
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
        }
    }
}

struct InviteFriendsSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var emailAddress: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                Text("Invite friends")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .padding(.top, 20)
                    .padding(.bottom, 24)
            
            // Email Input Section
            VStack(alignment: .leading, spacing: 8) {
                Text("iCloud Email")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                
                TextField("friend@icloud.com", text: $emailAddress)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6).opacity(0.5))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.separator), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
            }
            
            Spacer()
            
            // Send invitation button
            Button("Send invitation") {
                // Send invitation action
            }
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ModalOne(moodColor: .green)
}
