import Foundation

struct FlatListing: Identifiable {
    let id = UUID()
    let ownerName: String
    let title: String
    let location: String
    let matchPercent: Int
    let price: String
    let timeAgo: String
    let imageName: String
    var isSaved: Bool = false
}

struct FlatRequirement: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
    let value: String
}

extension FlatListing {
    static let sample: [FlatListing] = [
        FlatListing(ownerName: "Vinay Bansal", title: "Private Room in Sector 62", location: "Noida", matchPercent: 60, price: "₹9500/Month", timeAgo: "2h ago", imageName: "listing1", isSaved: false),
        FlatListing(ownerName: "Lady Gaga", title: "2BHK Flat near Metro", location: "Delhi", matchPercent: 60, price: "₹18000/Month", timeAgo: "8h ago", imageName: "listing2", isSaved: false),
        FlatListing(ownerName: "Pranjal Mishra", title: "1BHK Flat near Galgotias", location: "Noida", matchPercent: 60, price: "₹9500/Month", timeAgo: "1d ago", imageName: "listing3", isSaved: false)
    ]
}

extension FlatRequirement {
    static let sample: [FlatRequirement] = [
        FlatRequirement(icon: "paperplane", label: "Location", value: "Greater Noida"),
        FlatRequirement(icon: "dollarsign.circle", label: "Budget", value: "10,000 - 15000/ month"),
        FlatRequirement(icon: "house", label: "Type", value: "2BHK - Fully Furnished"),
        FlatRequirement(icon: "clock", label: "Stay Duration", value: "Within a month")
    ]
}
