import SwiftData
import Foundation

@Model
class FlatmateListing {
    @Attribute(.unique) var id: UUID = UUID()
    var ownerID: UUID
    var createdAt: Date = Date()
    
    // Property basics
    var propertyName: String
    var propertyType: String
    var roomType: String
    var location: String
    var rent: Double
    var genderPreference: String
    
    var listingDescription: String
    var images: [String] = []
    
    var suitabilityScore: Int = 0
    
    // MARK: - Required Lifestyle Traits
    
    var cleanlinessLevel: Int = 3
    var sleepSchedule: String = "moderate"
    var smokingPreference: String = "no"
    var petsPreference: String = "indifferent"
    var foodPreference: String = "any"
    var guestFrequency: String = "sometimes"
    var noiseLevel: String = "moderate"
    
    init(ownerID: UUID, propertyName: String, propertyType: String = "apartment", roomType: String = "single", location: String, rent: Double, genderPreference: String = "any", description: String = "") {
        self.ownerID = ownerID
        self.propertyName = propertyName
        self.propertyType = propertyType
        self.roomType = roomType
        self.location = location
        self.rent = rent
        self.genderPreference = genderPreference
        self.listingDescription = description
    }
}
