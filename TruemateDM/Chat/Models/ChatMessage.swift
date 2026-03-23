import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isSent: Bool
    let time: String
}

extension ChatMessage {
    static let sample: [ChatMessage] = [
        ChatMessage(text: "Hey! I want to connect", isSent: true, time: "13:58")
    ]
}
