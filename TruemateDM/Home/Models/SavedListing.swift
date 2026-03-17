import SwiftData
import Foundation

@Model
class SavedListing {

    var id: UUID
    var userID: UUID
    var listingID: UUID
    var savedAt: Date

    init(userID: UUID, listingID: UUID) {
        self.id = UUID()
        self.userID = userID
        self.listingID = listingID
        self.savedAt = Date()
    }
}
