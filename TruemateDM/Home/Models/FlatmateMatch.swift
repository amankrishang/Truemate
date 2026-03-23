import Foundation

struct FlatmateMatch: Identifiable {
    let id = UUID()
    let name: String
    let lookingFor: String
    let matchPercent: Int
    let pricePerMonth: Int
    let timeAgo: String
}

extension FlatmateMatch {
    static let sample: [FlatmateMatch] = [
        FlatmateMatch(name: "Vinay Bansal", lookingFor: "Looking for 2 BHK Apartment", matchPercent: 90, pricePerMonth: 9500, timeAgo: "2h ago"),
        FlatmateMatch(name: "Lady Gaga", lookingFor: "Looking for 1RK Apartment", matchPercent: 90, pricePerMonth: 18000, timeAgo: "8h ago"),
        FlatmateMatch(name: "Abhishek Gupta", lookingFor: "Looking for 2 BHK Apartment", matchPercent: 38, pricePerMonth: 9500, timeAgo: "1d ago")
    ]
}
