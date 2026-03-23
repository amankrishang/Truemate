import Foundation

struct Flatmate: Identifiable {
    let id = UUID()
    let name: String
    let lookingFor: String
    let location: String
    let pricePerMonth: Int
    let matchPercent: Int
    let isVerified: Bool
    var isSaved: Bool
}

extension Flatmate {
    static let sample: [Flatmate] = [
        Flatmate(name: "Vinay Bansal", lookingFor: "Looking for 2 BHK Apartment", location: "Greater Noida", pricePerMonth: 12000, matchPercent: 90, isVerified: true, isSaved: true),
        Flatmate(name: "Shalini", lookingFor: "Looking for 1RK Apartment", location: "Botanical Garden", pricePerMonth: 8500, matchPercent: 90, isVerified: true, isSaved: true),
        Flatmate(name: "Abhishek Gupta", lookingFor: "Looking for 2 BHK Apartment", location: "Beta 3", pricePerMonth: 12000, matchPercent: 38, isVerified: true, isSaved: false),
        Flatmate(name: "Pranjal Mishra", lookingFor: "Looking for 2 BHK Apartment", location: "Greater Noida", pricePerMonth: 12000, matchPercent: 50, isVerified: true, isSaved: false)
    ]
}
