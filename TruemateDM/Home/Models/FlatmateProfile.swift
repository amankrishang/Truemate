import Foundation

struct FlatmateProfile {
    let name: String
    let isVerified: Bool
    let suitabilityPercent: Int
    let matchTags: [MatchTag]
    let gender: String
    let flatType: String
    let lookingFor: String
    let flatRent: Int
    let age: Int
    var isSaved: Bool
}

struct MatchTag: Identifiable {
    let id = UUID()
    let label: String
    let icon: String
}

struct SuitabilityDetailsData {
    static let potentialMatches = [
        "Night Routine",
        "Budget",
        "Pets"
    ]

    static let potentialMismatches = [
        "Guests",
        "Cleaning",
        "Late Night Calls",
        "Household Responsibilities",
        "Communication"
    ]
}

extension FlatmateProfile {
    static let vinay = FlatmateProfile(
        name: "Vinay Bansal",
        isVerified: true,
        suitabilityPercent: 82,
        matchTags: [
            MatchTag(label: "Early Riser", icon: "sun.max.fill"),
            MatchTag(label: "Clean Home", icon: "sparkles"),
            MatchTag(label: "Budget", icon: "dollarsign.circle.fill")
        ],
        gender: "Male",
        flatType: "2 BHK",
        lookingFor: "Any",
        flatRent: 9500,
        age: 24,
        isSaved: false
    )

    static let ladyGaga = FlatmateProfile(
        name: "Lady Gaga",
        isVerified: true,
        suitabilityPercent: 74,
        matchTags: [
            MatchTag(label: "Creative", icon: "music.note"),
            MatchTag(label: "Pet Lover", icon: "pawprint.fill"),
            MatchTag(label: "Social", icon: "person.2.fill")
        ],
        gender: "Female",
        flatType: "1 RK",
        lookingFor: "Any",
        flatRent: 18000,
        age: 29,
        isSaved: false
    )

    static let abhishek = FlatmateProfile(
        name: "Abhishek Gupta",
        isVerified: true,
        suitabilityPercent: 38,
        matchTags: [
            MatchTag(label: "Night Owl", icon: "moon.fill"),
            MatchTag(label: "Budget", icon: "dollarsign.circle.fill"),
            MatchTag(label: "Pet Lover", icon: "pawprint.fill")
        ],
        gender: "Male",
        flatType: "3 BHK",
        lookingFor: "Male",
        flatRent: 12000,
        age: 22,
        isSaved: false
    )

    static let shalini = FlatmateProfile(
        name: "Shalini",
        isVerified: true,
        suitabilityPercent: 90,
        matchTags: [
            MatchTag(label: "Neat", icon: "sparkles"),
            MatchTag(label: "Budget", icon: "dollarsign.circle.fill"),
            MatchTag(label: "Early Bird", icon: "sun.max.fill")
        ],
        gender: "Female",
        flatType: "1 RK",
        lookingFor: "Any",
        flatRent: 8500,
        age: 23,
        isSaved: true
    )

    static let pranjal = FlatmateProfile(
        name: "Pranjal Mishra",
        isVerified: true,
        suitabilityPercent: 50,
        matchTags: [
            MatchTag(label: "Flexible", icon: "arrow.triangle.2.circlepath"),
            MatchTag(label: "Quiet", icon: "moon.stars.fill"),
            MatchTag(label: "Budget", icon: "dollarsign.circle.fill")
        ],
        gender: "Male",
        flatType: "2 BHK",
        lookingFor: "Any",
        flatRent: 12000,
        age: 25,
        isSaved: false
    )

    static let byName: [String: FlatmateProfile] = [
        "Vinay Bansal": .vinay,
        "Lady Gaga": .ladyGaga,
        "Shalini": .shalini,
        "Pranjal Mishra": .pranjal,
        "Abhishek Gupta": .abhishek
    ]

    static func from(name: String) -> FlatmateProfile {
        byName[name] ?? .abhishek
    }
}
