import SwiftUI

struct ChatPreview: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let hasUnread: Bool
    let avatarColor: Color
    let avatarSystemImage: String
}

