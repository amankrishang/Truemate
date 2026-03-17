import SwiftData
import Foundation

@Model
class MatchRequest {

    var id: UUID
    var senderID: UUID
    var receiverID: UUID

    var status: String
    var createdAt: Date

    init(senderID: UUID, receiverID: UUID, status: String) {

        self.id = UUID()
        self.senderID = senderID
        self.receiverID = receiverID
        self.status = status
        self.createdAt = Date()
    }
}
