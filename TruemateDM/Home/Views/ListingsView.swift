import SwiftUI
import SwiftData

struct ListingsView: View {
    var listings: [FlatmateListing]
    var currentUserID: UUID

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                // Summary header
                HStack {
                    Text("\(listings.count) matches found")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    Spacer()
                    Menu {
                        Button("Suitability ↓") {}
                        Button("Rent: Low → High") {}
                        Button("Rent: High → Low") {}
                        Button("Newest First") {}
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.up.arrow.down")
                            Text("Sort")
                        }
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(accentColor)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)

                ForEach(listings, id: \.id) { listing in
                    NavigationLink(destination: ListingDetailView(listing: listing, currentUserID: currentUserID)) {
                        ListingCardView(listing: listing)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 20)
        }
    }
}
