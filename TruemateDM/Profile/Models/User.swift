import SwiftData
import Foundation

enum UserMode: String, Codable, CaseIterable {
    case findFlats = "findFlats"
    case findFlatmates = "findFlatmates"
    case both = "both"

    var displayName: String {
        switch self {
        case .findFlats: return "Find Flats"
        case .findFlatmates: return "Find Flatmates"
        case .both: return "Both"
        }
    }

    var icon: String {
        switch self {
        case .findFlats: return "building.2"
        case .findFlatmates: return "person.2"
        case .both: return "arrow.left.arrow.right"
        }
    }
}

@Model
class User {
    var id: UUID
    var fullName: String
    var email: String
    var phoneNumber: String
    var age: Int
    var profilePhotoURL: String
    var activeModeRaw: String
    var canFindFlats: Bool
    var canFindFlatmates: Bool
    var isOnboardingComplete: Bool
    var createdAt: Date

    var activeMode: UserMode {
        get { UserMode(rawValue: activeModeRaw) ?? .both }
        set { activeModeRaw = newValue.rawValue }
    }

    init(
        fullName: String = "",
        email: String = "",
        phoneNumber: String = "",
        age: Int = 25,
        profilePhotoURL: String = "",
        activeMode: UserMode = .both,
        canFindFlats: Bool = true,
        canFindFlatmates: Bool = true,
        isOnboardingComplete: Bool = false
    ) {
        self.id = UUID()
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.profilePhotoURL = profilePhotoURL
        self.activeModeRaw = activeMode.rawValue
        self.canFindFlats = canFindFlats
        self.canFindFlatmates = canFindFlatmates
        self.isOnboardingComplete = isOnboardingComplete
        self.createdAt = Date()
    }
}
