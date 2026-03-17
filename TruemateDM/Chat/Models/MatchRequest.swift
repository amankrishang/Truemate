import SwiftData
import Foundation

@Model
class MatchRequest {
    @Attribute(.unique) var id: UUID = UUID()
    var senderID: UUID
    var receiverID: UUID
    var status: String
    var createdAt: Date = Date()
    
    init(senderID: UUID, receiverID: UUID, status: String = "pending") {
        self.senderID = senderID
        self.receiverID = receiverID
        self.status = status
    }
}
