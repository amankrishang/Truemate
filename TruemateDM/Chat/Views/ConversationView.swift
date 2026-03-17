import SwiftUI
import SwiftData

struct ConversationView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allMessages: [Message]
    @Query private var users: [User]

    var matchRequest: MatchRequest

    @State private var messageText: String = ""

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    private var currentUser: User? { users.first }

    private var isUnlocked: Bool { matchRequest.status == "accepted" }

    private var messages: [Message] {
        guard let user = currentUser else { return [] }
        let otherID = matchRequest.senderID == user.id ? matchRequest.receiverID : matchRequest.senderID
        return allMessages.filter {
            ($0.senderID == user.id && $0.receiverID == otherID) ||
            ($0.senderID == otherID && $0.receiverID == user.id)
        }.sorted { $0.timestamp < $1.timestamp }
    }

    var body: some View {
        VStack(spacing: 0) {
            if isUnlocked {
                unlockedChat
            } else {
                lockedChat
            }
        }
        .navigationTitle("Conversation")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if matchRequest.status == "pending" && matchRequest.receiverID == currentUser?.id {
                    Menu {
                        Button("Accept") { updateStatus("accepted") }
                        Button("Reject", role: .destructive) { updateStatus("rejected") }
                    } label: {
                        Text("Respond")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(accentColor)
                    }
                }
            }
        }
    }

    // MARK: - Unlocked Chat
    private var unlockedChat: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    // System message
                    Text("🎉 Match accepted! You can now chat.")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.top, 12)

                    ForEach(messages, id: \.id) { message in
                        messageBubble(message)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }

            Divider()

            // Message input
            HStack(spacing: 12) {
                TextField("Type a message...", text: $messageText)
                    .font(.system(size: 16))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(24)

                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 34))
                        .foregroundColor(messageText.isEmpty ? .secondary : accentColor)
                }
                .disabled(messageText.isEmpty)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
        }
    }

    private func messageBubble(_ message: Message) -> some View {
        let isMe = message.senderID == currentUser?.id
        return HStack {
            if isMe { Spacer(minLength: 60) }
            VStack(alignment: isMe ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.system(size: 15))
                    .foregroundColor(isMe ? .white : .primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(isMe ? accentColor : Color(.systemGray5))
                    .cornerRadius(18)

                Text(formatTime(message.timestamp))
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            if !isMe { Spacer(minLength: 60) }
        }
    }

    // MARK: - Locked Chat
    private var lockedChat: some View {
        VStack(spacing: 24) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 120, height: 120)
                Image(systemName: matchRequest.status == "rejected" ? "xmark.circle.fill" : "lock.fill")
                    .font(.system(size: 48))
                    .foregroundColor(matchRequest.status == "rejected" ? .red.opacity(0.6) : .secondary)
            }

            VStack(spacing: 8) {
                Text(matchRequest.status == "rejected" ? "Request Declined" : "Chat Locked")
                    .font(.system(size: 22, weight: .bold))
                Text(matchRequest.status == "rejected"
                     ? "This match request was not accepted."
                     : "Chat will unlock once your\nmatch request is accepted.")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

            if matchRequest.status == "pending" {
                HStack(spacing: 6) {
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("Waiting for response...")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(20)
            }

            Spacer()
        }
    }

    // MARK: - Actions
    private func sendMessage() {
        guard let user = currentUser, !messageText.isEmpty else { return }
        let otherID = matchRequest.senderID == user.id ? matchRequest.receiverID : matchRequest.senderID
        let message = Message(senderID: user.id, receiverID: otherID, text: messageText)
        modelContext.insert(message)
        try? modelContext.save()
        messageText = ""
    }

    private func updateStatus(_ status: String) {
        matchRequest.status = status
        try? modelContext.save()
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
