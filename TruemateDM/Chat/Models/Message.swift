import SwiftData
import Foundation

@Model
class Message {
    @Attribute(.unique) var id: UUID = UUID()
    var senderID: UUID
    var receiverID: UUID
    var text: String
    var timestamp: Date = Date()
    
    init(senderID: UUID, receiverID: UUID, text: String) {
        self.senderID = senderID
        self.receiverID = receiverID
        self.text = text
    }
}
