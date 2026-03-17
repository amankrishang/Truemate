import SwiftData
import Foundation

@Model
class FlatOwnerProfile {

    var id: UUID
    var userID: UUID

    var fullName: String
    var email: String
    var phoneNumber: String
    var age: Int

    var propertyName: String
    var propertyAddress: String
    var city: String
    var postalCode: String

    var propertyImages: [String]
    var arModelFile: String

    var rent: Double
    var availableFrom: Date
    var preferredTenantType: String  // "male", "female", "any"

    // Lifestyle preferences for matching
    var cleanlinessLevel: Int
    var sleepSchedule: String
    var smokingPreference: String
    var petsPreference: String
    var foodPreference: String
    var guestFrequency: String
    var noiseLevel: String

    var aadhaarVerified: Bool

    init(
        userID: UUID,
        fullName: String = "",
        email: String = "",
        phoneNumber: String = "",
        age: Int = 25,
        propertyName: String = "",
        propertyAddress: String = "",
        city: String = "",
        postalCode: String = "",
        propertyImages: [String] = [],
        arModelFile: String = "",
        rent: Double = 0,
        availableFrom: Date = Date(),
        preferredTenantType: String = "any",
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
        self.propertyName = propertyName
        self.propertyAddress = propertyAddress
        self.city = city
        self.postalCode = postalCode
        self.propertyImages = propertyImages
        self.arModelFile = arModelFile
        self.rent = rent
        self.availableFrom = availableFrom
        self.preferredTenantType = preferredTenantType
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
