import SwiftData
import Foundation

@Model
class FlatSeekerProfile {

    var id: UUID
    var userID: UUID

    var fullName: String
    var email: String
    var phoneNumber: String
    var age: Int

    var address: String
    var city: String
    var postalCode: String

    var workProfile: String
    var profilePhoto: String

    // Lifestyle preferences (1-5 scale for suitability scoring)
    var cleanlinessLevel: Int
    var sleepSchedule: String   // "early", "moderate", "late"
    var smokingPreference: String // "no", "occasionally", "yes"
    var petsPreference: String   // "no", "yes", "indifferent"
    var foodPreference: String   // "veg", "nonveg", "vegan", "any"
    var guestFrequency: String   // "rarely", "sometimes", "often"
    var noiseLevel: String       // "quiet", "moderate", "loud"

    var aadhaarVerified: Bool

    init(
        userID: UUID,
        fullName: String = "",
        email: String = "",
        phoneNumber: String = "",
        age: Int = 25,
        address: String = "",
        city: String = "",
        postalCode: String = "",
        workProfile: String = "",
        profilePhoto: String = "",
        cleanlinessLevel: Int = 3,
        sleepSchedule: String = "moderate",
        smokingPreference: String = "no",
        petsPreference: String = "indifferent",
        foodPreference: String = "any",
        guestFrequency: String = "sometimes",
        noiseLevel: String = "moderate",
        aadhaarVerified: Bool = false
    ) {
        self.id = UUID()
        self.userID = userID
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.address = address
        self.city = city
        self.postalCode = postalCode
        self.workProfile = workProfile
        self.profilePhoto = profilePhoto
        self.cleanlinessLevel = cleanlinessLevel
        self.sleepSchedule = sleepSchedule
        self.smokingPreference = smokingPreference
        self.petsPreference = petsPreference
        self.foodPreference = foodPreference
        self.guestFrequency = guestFrequency
        self.noiseLevel = noiseLevel
        self.aadhaarVerified = aadhaarVerified
    }
}
