import SwiftUI
import SwiftData

struct ListingDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var savedListings: [SavedListing]
    @Query private var matchRequests: [MatchRequest]

    var listing: FlatmateListing
    var currentUserID: UUID

    @State private var showMatchRequestSent = false
    @State private var showSuitabilityDetails = false
    @State private var showARPreview = false

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    private var isSaved: Bool {
        savedListings.contains { $0.listingID == listing.id && $0.userID == currentUserID }
    }

    private var hasExistingRequest: Bool {
        matchRequests.contains { $0.senderID == currentUserID && $0.receiverID == listing.ownerID }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero image placeholder
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [accentColor.opacity(0.2), accentColor.opacity(0.05)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 280)
                        .overlay(
                            Image(systemName: propertyIcon)
                                .font(.system(size: 64))
                                .foregroundColor(accentColor.opacity(0.3))
                        )

                    // Suitability overlay
                    Button(action: { showSuitabilityDetails = true }) {
                        HStack(spacing: 6) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 14))
                            Text("\(listing.suitabilityScore)% Suitability")
                                .font(.system(size: 15, weight: .bold))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 11))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(suitabilityColor)
                        .cornerRadius(24)
                    }
                    .padding(16)
                }

                VStack(alignment: .leading, spacing: 20) {
                    // Title & Price
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(listing.propertyName)
                                .font(.system(size: 24, weight: .bold))
                            HStack(spacing: 4) {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(accentColor)
                                Text(listing.location)
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("₹\(Int(listing.rent))")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(accentColor)
                            Text("/month")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                    }

                    Divider()

                    // Quick Info
                    HStack(spacing: 0) {
                        infoItem(icon: "building.2.fill", title: listing.propertyType.capitalized, subtitle: "Type")
                        Spacer()
                        infoItem(icon: "bed.double.fill", title: listing.roomType.capitalized, subtitle: "Room")
                        Spacer()
                        infoItem(icon: "person.fill", title: listing.genderPreference.capitalized, subtitle: "Gender")
                    }
                    .padding(.vertical, 4)

                    Divider()

                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About this place")
                            .font(.system(size: 18, weight: .semibold))
                        Text(listing.listingDescription)
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }

                    Divider()

                    // Lifestyle tags
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Lifestyle")
                            .font(.system(size: 18, weight: .semibold))

                        FlowLayout(spacing: 8) {
                            lifestyleTag(icon: "sparkles", text: "Cleanliness: \(listing.cleanlinessLevel)/5")
                            lifestyleTag(icon: "moon.fill", text: "Sleep: \(listing.sleepSchedule.capitalized)")
                            lifestyleTag(icon: "nosign", text: "Smoking: \(listing.smokingPreference.capitalized)")
                            lifestyleTag(icon: "leaf.fill", text: "Food: \(listing.foodPreference.capitalized)")
                            lifestyleTag(icon: "speaker.wave.2.fill", text: "Noise: \(listing.noiseLevel.capitalized)")
                        }
                    }

                    // AR Preview button
                    Button(action: { showARPreview = true }) {
                        HStack(spacing: 8) {
                            Image(systemName: "arkit")
                            Text("View AR Preview")
                        }
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(accentColor)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(accentColor.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                .padding(20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: toggleSaved) {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isSaved ? accentColor : .secondary)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            // Bottom CTA
            VStack(spacing: 0) {
                Divider()
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("₹\(Int(listing.rent))/mo")
                            .font(.system(size: 18, weight: .bold))
                        Text("\(listing.suitabilityScore)% match")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button(action: sendMatchRequest) {
                        Text(hasExistingRequest ? "Request Sent" : "Send Match Request")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                            .background(hasExistingRequest ? Color.gray : accentColor)
                            .cornerRadius(12)
                    }
                    .disabled(hasExistingRequest)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
            }
        }
        .sheet(isPresented: $showMatchRequestSent) {
            MatchRequestSentView()
        }
        .sheet(isPresented: $showSuitabilityDetails) {
            NavigationStack {
                SuitabilityDetailsView(listing: listing)
            }
        }
        .sheet(isPresented: $showARPreview) {
            NavigationStack {
                ARPreviewView(propertyName: listing.propertyName)
            }
        }
    }

    private func infoItem(icon: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(accentColor)
            Text(title)
                .font(.system(size: 14, weight: .semibold))
            Text(subtitle)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private func lifestyleTag(icon: String, text: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10))
            Text(text)
                .font(.system(size: 12, weight: .medium))
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }

    private var propertyIcon: String {
        switch listing.propertyType {
        case "apartment": return "building.2.fill"
        case "villa": return "house.fill"
        case "pg": return "bed.double.fill"
        default: return "building.fill"
        }
    }

    private var suitabilityColor: Color {
        if listing.suitabilityScore >= 80 { return Color.green }
        if listing.suitabilityScore >= 60 { return Color.orange }
        return Color.red
    }

    private func toggleSaved() {
        if let existing = savedListings.first(where: { $0.listingID == listing.id && $0.userID == currentUserID }) {
            modelContext.delete(existing)
        } else {
            modelContext.insert(SavedListing(userID: currentUserID, listingID: listing.id))
        }
        try? modelContext.save()
    }

    private func sendMatchRequest() {
        guard !hasExistingRequest else { return }
        let request = MatchRequest(senderID: currentUserID, receiverID: listing.ownerID, status: "pending")
        modelContext.insert(request)
        try? modelContext.save()
        showMatchRequestSent = true
    }
}

// MARK: - Flow Layout
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }

    private func arrangeSubviews(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var maxHeight: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth && x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            maxHeight = max(maxHeight, y + rowHeight)
        }

        return (CGSize(width: maxWidth, height: maxHeight), positions)
    }
}
