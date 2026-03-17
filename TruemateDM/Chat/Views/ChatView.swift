import SwiftUI
import SwiftData

struct ChatView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var matchRequests: [MatchRequest]
    @Query private var users: [User]
    @Query private var listings: [FlatmateListing]

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    private var currentUser: User? { users.first }

    private var relevantRequests: [MatchRequest] {
        guard let user = currentUser else { return [] }
        return matchRequests.filter { $0.senderID == user.id || $0.receiverID == user.id }
    }

    var body: some View {
        Group {
            if relevantRequests.isEmpty {
                emptyState
            } else {
                conversationsList
            }
        }
        .navigationTitle("Messages")
    }

    private var emptyState: some View {
        VStack(spacing: 20) {
            Spacer()
            ZStack {
                Circle()
                    .fill(accentColor.opacity(0.08))
                    .frame(width: 120, height: 120)
                Image(systemName: "message.fill")
                    .font(.system(size: 44))
                    .foregroundColor(accentColor.opacity(0.4))
            }
            Text("No Conversations Yet")
                .font(.system(size: 22, weight: .bold))
            Text("Send a match request from a listing\nto start a conversation.")
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }

    private var conversationsList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(relevantRequests, id: \.id) { request in
                    NavigationLink(destination: ConversationView(matchRequest: request)) {
                        chatRow(request: request)
                    }
                    .buttonStyle(.plain)

                    Divider()
                        .padding(.leading, 76)
                }
            }
        }
    }

    private func chatRow(request: MatchRequest) -> some View {
        HStack(spacing: 14) {
            // Avatar
            ZStack {
                Circle()
                    .fill(accentColor.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: "person.fill")
                    .font(.system(size: 22))
                    .foregroundColor(accentColor)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(listingName(for: request))
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                    Spacer()
                    Text(timeAgo(request.createdAt))
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 6) {
                    statusBadge(request.status)
                    Text(statusMessage(request.status))
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }

    private func statusBadge(_ status: String) -> some View {
        Text(status.capitalized)
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(statusColor(status))
            .cornerRadius(4)
    }

    private func statusColor(_ status: String) -> Color {
        switch status {
        case "accepted": return .green
        case "rejected": return .red
        default: return .orange
        }
    }

    private func statusMessage(_ status: String) -> String {
        switch status {
        case "accepted": return "Chat unlocked — say hi!"
        case "rejected": return "Request declined"
        default: return "Waiting for response..."
        }
    }

    private func listingName(for request: MatchRequest) -> String {
        if let listing = listings.first(where: { $0.ownerID == request.receiverID }) {
            return listing.propertyName
        }
        return "Match Request"
    }

    private func timeAgo(_ date: Date) -> String {
        let interval = Date().timeIntervalSince(date)
        if interval < 60 { return "Just now" }
        if interval < 3600 { return "\(Int(interval / 60))m ago" }
        if interval < 86400 { return "\(Int(interval / 3600))h ago" }
        return "\(Int(interval / 86400))d ago"
    }
}
