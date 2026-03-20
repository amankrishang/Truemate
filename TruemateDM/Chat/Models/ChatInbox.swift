import SwiftUI
import Combine

final class ChatInbox: ObservableObject {
    @Published var chats: [ChatPreview] = []

    func addAbhishekIfNeeded() {
        guard chats.contains(where: { $0.name == "Abhishek Gupta" }) == false else { return }
        chats.insert(
            ChatPreview(
                name: "Abhishek Gupta",
                lastMessage: "Match request sent. Tap to open chat",
                hasUnread: true,
                avatarColor: .blue,
                avatarSystemImage: "person.fill"
            ),
            at: 0
        )
    }
}
