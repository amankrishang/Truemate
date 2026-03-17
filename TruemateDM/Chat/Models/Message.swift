import SwiftData
import Foundation

@Model
class Message {

    var id: UUID
    var senderID: UUID
    var receiverID: UUID

    var text: String
    var timestamp: Date

    init(senderID: UUID, receiverID: UUID, text: String) {

        self.id = UUID()
        self.senderID = senderID
        self.receiverID = receiverID
        self.text = text
        self.timestamp = Date()
    }
}
