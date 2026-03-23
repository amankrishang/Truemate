import Foundation

struct ListingMatch: Identifiable {
    let id = UUID()
    let name: String
    let lookingFor: String
    let pricePerMonth: Int
    let timeAgo: String
    let imageName: String
}

extension ListingMatch {
    static let sample: [ListingMatch] = [
        ListingMatch(name: "Vinay Bansal", lookingFor: "Looking for 2 BHK Apartment", pricePerMonth: 9500, timeAgo: "2h ago", imageName: "person.crop.circle.fill"),
        ListingMatch(name: "Lady Gaga", lookingFor: "Looking for 1RK Apartment", pricePerMonth: 18000, timeAgo: "8h ago", imageName: "person.crop.circle.fill"),
        ListingMatch(name: "Abhishek Gupta", lookingFor: "Looking for 2 BHK Apartment", pricePerMonth: 9500, timeAgo: "1d ago", imageName: "person.crop.circle.fill")
    ]
}
