import SwiftData
import Foundation

@Model
class SavedListing {
    @Attribute(.unique) var id: UUID = UUID()
    var userID: UUID
    var listingID: UUID
    var savedAt: Date = Date()
    
    init(userID: UUID, listingID: UUID) {
        self.userID = userID
        self.listingID = listingID
    }
}
