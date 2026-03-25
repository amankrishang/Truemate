import SwiftUI
import Combine

class ChatInbox: ObservableObject {
    static let shared = ChatInbox()
    @Published var chats: [ChatPreview] = []

    func addChatIfNeeded(name: String) {
        for chat in chats {
            if chat.name == name {
                return
            }
        }

        let newChat = ChatPreview(
            name: name,
            lastMessage: "Match request sent. Tap to open chat",
            hasUnread: true,
            avatarColor: .blue,
            avatarSystemImage: "person.fill"
        )

        chats.insert(newChat, at: 0)
    }
}
