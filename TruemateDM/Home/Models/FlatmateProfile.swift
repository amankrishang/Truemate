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
    static let allTopics = [
        "Night Routine",
        "Budget",
        "Guests",
        "Pets",
        "Cleaning",
        "Late Night Calls",
        "Household Responsibilities",
        "Communication",
        "Music Volume",
        "Work From Home",
        "Food Preferences",
        "Sleep Schedule",
        "Visitors Frequency",
        "Utility Sharing",
        "Weekend Plans",
        "Personal Space"
    ]

    static func randomSet(for name: String) -> (matches: [String], mismatches: [String]) {
        let _ = name
        var topics = allTopics.shuffled()

        var matchCount = Int.random(in: 2...7)
        var mismatchCount = Int.random(in: 2...7)

        if matchCount + mismatchCount > topics.count {
            let maxMismatch = max(2, topics.count - matchCount)
            mismatchCount = min(mismatchCount, maxMismatch)
        }

        if matchCount + mismatchCount > topics.count {
            let maxMatch = max(2, topics.count - mismatchCount)
            matchCount = min(matchCount, maxMatch)
        }

        let matches = Array(topics.prefix(matchCount))
        topics.removeFirst(matchCount)
        let mismatches = Array(topics.prefix(mismatchCount))

        return (matches, mismatches)
    }
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
