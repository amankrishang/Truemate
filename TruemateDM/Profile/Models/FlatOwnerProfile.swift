import SwiftData
import Foundation

@Model
class FlatOwnerProfile {
    @Attribute(.unique) var id: UUID = UUID()
    var userID: UUID
    
    // Personal Details
    var fullName: String
    var email: String
    var phoneNumber: String
    var age: Int
    var aadhaarVerified: Bool = false
    
    // Property Details
    var propertyName: String = ""
    var propertyAddress: String = ""
    var city: String = ""
    var postalCode: String = ""
    var propertyImages: [String] = []
    
    // Optional AR Map File Path
    var arModelFile: String?
    
    // Rent & Availability
    var rent: Double = 0.0
    var availableFrom: Date = Date()
    var preferredTenantType: String = "any"
    
    // MARK: - Lifestyle Expectations
    
    var cleanlinessLevel: Int = 3
    var sleepSchedule: String = "moderate"
    var smokingPreference: String = "no"
    var petsPreference: String = "indifferent"
    var foodPreference: String = "any"
    var guestFrequency: String = "sometimes"
    var noiseLevel: String = "moderate"
    
    init(userID: UUID, fullName: String, email: String, phoneNumber: String, age: Int) {
        self.userID = userID
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
    }
}
