import SwiftData
import Foundation

@Model
class FlatSeekerPost {

    var id: UUID
    var userID: UUID

    var preferredLocation: String
    var budget: Double
    var moveInDate: Date

    var details: String

    init(
        userID: UUID,
        preferredLocation: String,
        budget: Double,
        moveInDate: Date,
        details: String
    ) {

        self.id = UUID()
        self.userID = userID
        self.preferredLocation = preferredLocation
        self.budget = budget
        self.moveInDate = moveInDate
        self.details = details
    }
}
