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

extension FlatmateProfile {
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
}
