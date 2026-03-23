import SwiftUI
import Combine

class ChatInbox: ObservableObject {
    static let shared = ChatInbox()
    @Published var chats: [ChatPreview] = []

    func addAbhishekIfNeeded() {
        for chat in chats {
            if chat.name == "Abhishek Gupta" {
                return
            }
        }

        let abhishekChat = ChatPreview(
            name: "Abhishek Gupta",
            lastMessage: "Match request sent. Tap to open chat",
            hasUnread: true,
            avatarColor: .blue,
            avatarSystemImage: "person.fill"
        )

        chats.insert(abhishekChat, at: 0)
    }
}
