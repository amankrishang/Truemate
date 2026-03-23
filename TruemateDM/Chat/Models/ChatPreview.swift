import SwiftUI

struct ChatPreview: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let hasUnread: Bool
    let avatarColor: Color
    let avatarSystemImage: String
}

struct ChatMenuOptions {
    static let items = ["Edit Chats", "Sent Requests", "Received Requests"]
}
