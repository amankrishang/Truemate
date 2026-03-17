import SwiftUI
import SwiftData

struct SavedListingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var savedListings: [SavedListing]
    @Query private var allListings: [FlatmateListing]

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    private var savedFlatmateListings: [FlatmateListing] {
        let savedIDs = Set(savedListings.map { $0.listingID })
        return allListings.filter { savedIDs.contains($0.id) }
    }

    var body: some View {
        Group {
            if savedFlatmateListings.isEmpty {
                VStack(spacing: 16) {
                    Spacer()
                    Image(systemName: "bookmark")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary.opacity(0.4))
                    Text("No Saved Listings")
                        .font(.system(size: 20, weight: .bold))
                    Text("Listings you save will appear here")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(savedFlatmateListings, id: \.id) { listing in
                            ListingCardView(listing: listing)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationTitle("Saved")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") { dismiss() }
                    .foregroundColor(accentColor)
            }
        }
    }
}
