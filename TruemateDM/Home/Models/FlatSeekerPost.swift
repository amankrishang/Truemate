import SwiftData
import Foundation

@Model
class FlatSeekerPost {
    @Attribute(.unique) var id: UUID = UUID()
    var userID: UUID
    var postedAt: Date = Date()
    
    var preferredLocation: String
    var budget: Double
    var moveInDate: Date
    
    var details: String
    
    init(userID: UUID, preferredLocation: String, budget: Double, moveInDate: Date, details: String = "") {
        self.userID = userID
        self.preferredLocation = preferredLocation
        self.budget = budget
        self.moveInDate = moveInDate
        self.details = details
    }
}
