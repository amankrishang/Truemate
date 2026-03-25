import SwiftUI

struct FlatmatesMatchesWithRequirementView: View {
    @State private var activeSheet: FlatmatesSheet?
    @State private var selectedProfileName = ""

    let requirements = FlatRequirement.sample
    let listings = FlatListing.sample

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))

                        Text("Add requirements to unlock searches")
                            .font(.system(size: 15))
                            .foregroundColor(Color(UIColor.placeholderText))

                        Spacer()

                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 11)
                    .background(Color(UIColor.systemBackground))
                    .clipShape(Capsule())
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 20)

                    VStack(spacing: 10) {
                        HStack {
                            Text("My Requirements")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.primary)
                            Spacer()
                            HStack(spacing: 6) {
                                Button(action: { activeSheet = .edit }) {
                                    Image(systemName: "pencil")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 28)
                                        .background(Color.black)
                                        .clipShape(Circle())
                                }

                                Button(action: { activeSheet = .create }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 28)
                                        .background(Color.black)
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .padding(.horizontal, 16)

                        VStack(spacing: 0) {
                            ForEach(requirements.indices, id: \.self) { index in
                                RequirementRow(requirement: requirements[index])
                                if index < requirements.count - 1 {
                                    Divider().padding(.horizontal, 16)
                                }
                            }
                        }
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 24)

                    VStack(spacing: 10) {
                        Button(action: { activeSheet = .allListings }) {
                            HStack {
                                Text("All Listings")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 16)
                        }
                        .buttonStyle(.plain)

                        VStack(spacing: 10) {
                            ForEach(listings) { listing in
                                Button(action: {
                                    selectedProfileName = listing.ownerName
                                    activeSheet = .profile
                                }) {
                                    ListingCard(listing: listing)
                                        .padding(.horizontal, 16)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    Spacer(minLength: 40)
                }
                .padding(.top, 8)
            }
        }
        .navigationTitle("Matches")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.2))
                        .frame(width: 38, height: 38)
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                        .foregroundColor(.orange)
                }
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .create:
                CreatePostView(
                    isPresented: Binding(
                        get: { activeSheet == .create },
                        set: { if !$0 { activeSheet = nil } }
                    ),
                    onPostCreated: { activeSheet = nil }
                )
            case .edit:
                EditPostView(
                    isPresented: Binding(
                        get: { activeSheet == .edit },
                        set: { if !$0 { activeSheet = nil } }
                    )
                )
            case .allListings:
                AllListingsView(
                    isPresented: Binding(
                        get: { activeSheet == .allListings },
                        set: { if !$0 { activeSheet = nil } }
                    )
                )
            case .profile:
                NavigationStack {
                    FlatmateProfileView(
                        profile: FlatmateProfile.from(name: selectedProfileName),
                        onClose: { activeSheet = nil }
                    )
                }
            }
        }
    }
}

enum FlatmatesSheet: String, Identifiable {
    case create
    case edit
    case allListings
    case profile

    var id: String { rawValue }
}

struct RequirementRow: View {
    let requirement: FlatRequirement

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: requirement.icon)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: 20)

            Text(requirement.label)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: 90, alignment: .leading)

            Spacer()

            Text(requirement.value)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
    }
}

struct ListingCard: View {
    let listing: FlatListing

    var matchColor: Color {
        if listing.matchPercent >= 60 {
            return Color(red: 0.18, green: 0.7, blue: 0.45)
        }
        return .orange
    }

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .frame(width: 90, height: 90)

                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(.gray.opacity(0.35))
            }
            .frame(width: 90, height: 90)

            VStack(alignment: .leading, spacing: 4) {
                Text(listing.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)

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
    NavigationStack {
        FlatmatesMatchesWithRequirementView()
    }
}
