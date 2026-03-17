import SwiftData
import Foundation

@Model
class FlatmateListing {

    var id: UUID
    var ownerID: UUID

    var propertyType: String   // "apartment", "villa", "pg", "shared"
    var roomType: String       // "single", "double", "triple"
    var propertyName: String

    var location: String
    var rent: Double
    var genderPreference: String

    var listingDescription: String
    var images: [String]

    var suitabilityScore: Int  // 0-100
    var createdAt: Date

    // Lifestyle attributes for suitability calculation
    var cleanlinessLevel: Int
    var sleepSchedule: String
    var smokingPreference: String
    var petsPreference: String
    var foodPreference: String
    var guestFrequency: String
    var noiseLevel: String

    init(
        ownerID: UUID,
        propertyType: String = "apartment",
        roomType: String = "single",
        propertyName: String = "",
        location: String = "",
        rent: Double = 0,
        genderPreference: String = "any",
        listingDescription: String = "",
        images: [String] = [],
        suitabilityScore: Int = 0,
        cleanlinessLevel: Int = 3,
        sleepSchedule: String = "moderate",
        smokingPreference: String = "no",
        petsPreference: String = "indifferent",
        foodPreference: String = "any",
        guestFrequency: String = "sometimes",
        noiseLevel: String = "moderate"
    ) {
        self.id = UUID()
        self.ownerID = ownerID
        self.propertyType = propertyType
        self.roomType = roomType
        self.propertyName = propertyName
        self.location = location
        self.rent = rent
        self.genderPreference = genderPreference
        self.listingDescription = listingDescription
        self.images = images
        self.suitabilityScore = suitabilityScore
        self.createdAt = Date()
        self.cleanlinessLevel = cleanlinessLevel
        self.sleepSchedule = sleepSchedule
        self.smokingPreference = smokingPreference
        self.petsPreference = petsPreference
        self.foodPreference = foodPreference
        self.guestFrequency = guestFrequency
        self.noiseLevel = noiseLevel
    }
}
