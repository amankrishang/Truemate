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

class User {
    var id: UUID = UUID()

    var fullName: String
    var email: String
    var phoneNumber: String
    var age: Int
    var profilePhotoURL: String?
    var address: String
    var country: String
    var postalCode: String
    var city: String
    var aadhaarVerified: Bool

    var activeMode: UserMode = .both
    var isOnboardingComplete: Bool = false
    
    var createdAt: Date = Date()
    
    init(fullName: String = "", email: String = "", phoneNumber: String = "", age: Int = 25) {
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.address = ""
        self.country = ""
        self.postalCode = ""
        self.city = ""
        self.aadhaarVerified = false
    }
}

extension User {
    static var allUsers: [User] = []
    static var currentUser: User? = nil
}
