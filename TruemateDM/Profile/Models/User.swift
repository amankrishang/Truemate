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
    @Attribute(.unique) var id: UUID = UUID()
    
    // Profile info
    var fullName: String
    var email: String
    var phoneNumber: String
    var age: Int
    var profilePhotoURL: String?
    
    // App state
    var activeModeRaw: String = UserMode.both.rawValue
    var canFindFlats: Bool = true
    var canFindFlatmates: Bool = true
    var isOnboardingComplete: Bool = false
    
    var createdAt: Date = Date()
    
    var activeMode: UserMode {
        get { UserMode(rawValue: activeModeRaw) ?? .both }
        set { 
            activeModeRaw = newValue.rawValue
            canFindFlats = newValue == .findFlats || newValue == .both
            canFindFlatmates = newValue == .findFlatmates || newValue == .both
        }
    }
    
    init(fullName: String = "", email: String = "", phoneNumber: String = "", age: Int = 25) {
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
    }
}
