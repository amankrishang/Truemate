import SwiftUI

struct ListingCardView: View {
    var listing: FlatmateListing
    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image placeholder
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [accentColor.opacity(0.15), accentColor.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: propertyIcon)
                                .font(.system(size: 36))
                                .foregroundColor(accentColor.opacity(0.4))
                            Text(listing.propertyType.capitalized)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(accentColor.opacity(0.5))
                        }
                    )

                // Suitability badge
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 10))
                    Text("\(listing.suitabilityScore)%")
                        .font(.system(size: 13, weight: .bold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(suitabilityColor)
                .cornerRadius(20)
                .padding(12)
            }

            // Info section
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(listing.propertyName)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)
                            .lineLimit(1)

                        HStack(spacing: 4) {
                            Image(systemName: "mappin")
                                .font(.system(size: 11))
                            Text(listing.location)
                                .font(.system(size: 13))
                        }
                        .foregroundColor(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text("₹\(Int(listing.rent))")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(accentColor)
                        Text("/month")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }

                // Tags
                HStack(spacing: 8) {
                    tagView(text: listing.roomType.capitalized, icon: "bed.double.fill")
                    tagView(text: listing.genderPreference.capitalized, icon: "person.fill")
                    if listing.smokingPreference == "no" {
                        tagView(text: "No Smoking", icon: "nosign")
                    }
                }
            }
            .padding(16)
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
        .padding(.horizontal, 20)
    }

    private func tagView(text: String, icon: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 9))
            Text(text)
                .font(.system(size: 11, weight: .medium))
        }
        .foregroundColor(.secondary)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(Color(.systemGray6))
        .cornerRadius(6)
    }

    private var propertyIcon: String {
        switch listing.propertyType {
        case "apartment": return "building.2.fill"
        case "villa": return "house.fill"
        case "pg": return "bed.double.fill"
        case "shared": return "person.2.fill"
        default: return "building.fill"
        }
    }

    private var suitabilityColor: Color {
        if listing.suitabilityScore >= 80 { return Color.green }
        if listing.suitabilityScore >= 60 { return Color.orange }
        return Color.red
    }
}
