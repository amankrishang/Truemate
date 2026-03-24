import SwiftUI

struct AllListingsView: View {
    @Binding var isPresented: Bool
    @State private var selectedTab: ListingTab = .recommended
    @State private var listings = FlatListing.sample
    @State private var showListingProfile = false
    @State private var selectedProfileName = ""

    enum ListingTab {
        case recommended
        case saved
    }

    var currentListings: [FlatListing] {
        if selectedTab == .recommended {
            return listings
        }
        return listings.filter { $0.isSaved }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    ListingsSegmentedTabBar(selectedTab: $selectedTab)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 16)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            if currentListings.isEmpty {
                                Text("No listings found.")
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                                    .padding(.top, 60)
                            } else {
                                ForEach(currentListings) { listing in
                                    Button(action: {
                                        selectedProfileName = listing.ownerName
                                        saveListing(for: listing.id)
                                        showListingProfile = true
                                    }) {
                                        AllListingsCardView(listing: listing)
                                            .padding(.horizontal, 16)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("All listings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isPresented = false }) {
                        ZStack {
                            Circle()
                                .fill(Color(UIColor.systemBackground))
                                .frame(width: 32, height: 32)
                                .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 1)
                            Image(systemName: "chevron.left")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.primary)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationDestination(isPresented: $showListingProfile) {
                FlatmateProfileView(
                    onBack: nil,
                    profile: FlatmateProfile.from(name: selectedProfileName),
                    useBackButton: true
                )
            }
        }
    }

    private func saveListing(for id: UUID) {
        guard let index = listings.firstIndex(where: { $0.id == id }) else { return }
        listings[index].isSaved = true
    }
}

struct ListingsSegmentedTabBar: View {
    @Binding var selectedTab: AllListingsView.ListingTab

    var body: some View {
        HStack(spacing: 0) {
            ListingsTabButton(
                title: "Recommended listings",
                isSelected: selectedTab == .recommended,
                action: { selectedTab = .recommended }
            )
            ListingsTabButton(
                title: "Saved listings",
                isSelected: selectedTab == .saved,
                action: { selectedTab = .saved }
            )
        }
        .background(Color(UIColor.systemBackground))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color(UIColor.systemGray5), lineWidth: 0.5)
        )
    }
}

struct ListingsTabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 9)
                .background(
                    Group {
                        if isSelected {
                            Capsule().fill(Color.blue)
                        } else {
                            Color.clear
                        }
                    }
                )
                .padding(3)
        }
    }
}

struct AllListingsCardView: View {
    let listing: FlatListing

    var matchColor: Color {
        Color(red: 0.18, green: 0.7, blue: 0.45)
    }

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.secondarySystemFill))
                    .frame(width: 90, height: 90)
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28)
                    .foregroundColor(.gray.opacity(0.35))
            }
            .frame(width: 90, height: 90)

            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .top) {
                    Text(listing.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    Image(systemName: listing.isSaved ? "bookmark.circle.fill" : "bookmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(listing.isSaved ? .blue : .gray)
                }

                Text(listing.location)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)

                Text("\(listing.matchPercent)% Suitability")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(matchColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(matchColor.opacity(0.12))
                    .clipShape(Capsule())

                HStack {
                    Text(listing.price)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                    Spacer()
                    Text(listing.timeAgo)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(12)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    AllListingsView(isPresented: .constant(true))
}
