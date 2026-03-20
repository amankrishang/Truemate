import SwiftUI

struct ChatPreview: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let hasUnread: Bool
    let avatarColor: Color
    let avatarSystemImage: String
}

struct ChatsListView: View {
    @EnvironmentObject private var chatInbox: ChatInbox
    @State private var showOptionsMenu = false
    private let menuOptions = ["Edit Chats", "Sent Requests", "Received Requests"]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Chats")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.blue)

                            Spacer()

                            Button(action: { showOptionsMenu.toggle() }) {
                                ZStack {
                                    Circle()
                                        .stroke(Color(.systemGray3), lineWidth: 1.5)
                                        .frame(width: 38, height: 38)
                                    Image(systemName: "ellipsis")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.primary)
                                }
                            }

                            ZStack {
                                Circle()
                                    .fill(Color(.systemGray5))
                                    .frame(width: 38, height: 38)
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 24)

                        if chatInbox.chats.isEmpty {
                            VStack(spacing: 10) {
                                Text("No chats yet")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.primary)
                                Text("Send a message request to start chatting.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.systemGray))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 60)
                        } else {
                            VStack(spacing: 0) {
                                ForEach(Array(chatInbox.chats.enumerated()), id: \.element.id) { index, chat in
                                    NavigationLink(destination: SendMessageRequestView(contactName: chat.name)) {
                                        ChatRowView(chat: chat)
                                    }
                                    .buttonStyle(.plain)

                                    if index < chatInbox.chats.count - 1 {
                                        Divider()
                                            .padding(.leading, 80)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
                .background(Color(.systemGray6))

                if showOptionsMenu {
                    Color.black.opacity(0.001)
                        .ignoresSafeArea()
                        .onTapGesture { showOptionsMenu = false }

                    VStack(spacing: 0) {
                        ForEach(Array(menuOptions.enumerated()), id: \.offset) { index, title in
                            menuRow(title)
                            if index < menuOptions.count - 1 {
                                Divider().padding(.leading, 56)
                            }
                        }
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .overlay(
                        RoundedRectangle(cornerRadius: 26)
                            .stroke(Color.white.opacity(0.45), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.12), radius: 14, x: 0, y: 8)
                    .frame(width: 290)
                    .padding(.top, 72)
                    .padding(.trailing, 18)
                    .transition(.opacity.combined(with: .scale(scale: 0.97, anchor: .topTrailing)))
                }
            }
            .animation(.easeInOut(duration: 0.18), value: showOptionsMenu)
        }
    }

    @ViewBuilder
    private func menuRow(_ title: String) -> some View {
        Button(action: { showOptionsMenu = false }) {
            HStack(spacing: 12) {
                Image(systemName: "")
                    .frame(width: 20)
                Text(title)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct ChatRowView: View {
    let chat: ChatPreview

    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(chat.hasUnread ? Color.blue : Color.clear)
                .frame(width: 9, height: 9)

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(chat.avatarColor.opacity(0.25))
                    .frame(width: 52, height: 52)
                Image(systemName: chat.avatarSystemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(chat.avatarColor)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(chat.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                Text(chat.lastMessage)
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundColor(Color(.systemGray3))
                .padding(.top, 4)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(.systemGray6))
    }
}

#Preview {
    ChatsListView()
        .environmentObject(ChatInbox())
}
