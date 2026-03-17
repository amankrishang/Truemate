import SwiftData
import Foundation

@Model
class FlatSeekerProfile {
    @Attribute(.unique) var id: UUID = UUID()
    var userID: UUID
    
    // Personal Details
    var fullName: String
    var email: String
    var phoneNumber: String
    var age: Int
    
    // Current Location & Work
    var address: String = ""
    var city: String = ""
    var postalCode: String = ""
    var workProfile: String = ""
    var profilePhoto: String?
    
    var aadhaarVerified: Bool = false
    
    // MARK: - Lifestyle Preferences
    
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
