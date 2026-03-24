import SwiftUI

struct FlatmatesMatchesView: View {
    var onRequirementCreated: () -> Void
    let openCreateOnAppear: Bool
    @State private var showCreatePost = false
    @State private var didAutoOpen = false

    let listings = FlatListing.sample

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    Text("Add requirements to unlock searches")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .font(.system(size: 15))

                    Spacer()

                    Image(systemName: "mic.fill")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 16)

                FlatRequirementsBannerCard(onAddRequirements: {
                    showCreatePost = true
                })
                .padding(.horizontal, 16)
                .padding(.bottom, 20)

                VStack(spacing: 0) {
                    HStack {
                        Text("Listings based on your preferences")
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)

                    VStack(spacing: 0) {
                        ForEach(listings.indices, id: \.self) { index in
                            FlatListingRowView(listing: listings[index])
                            if index < listings.count - 1 {
                                Divider().padding(.leading, 108)
                            }
                        }
                    }
                    .background(Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 16)
                }

                Spacer(minLength: 40)
            }
            .padding(.top, 8)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Matches")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.15))
                        .frame(width: 36, height: 36)
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.orange)
                }
            }
        }
        .fullScreenCover(isPresented: $showCreatePost) {
            CreatePostView(isPresented: $showCreatePost, onPostCreated: {
                onRequirementCreated()
            })
        }
        .onAppear {
            if openCreateOnAppear && !didAutoOpen {
                didAutoOpen = true
                showCreatePost = true
            }
        }
    }
}

struct FlatRequirementsBannerCard: View {
    var onAddRequirements: () -> Void

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color(UIColor.systemBackground))
            .overlay(
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("You haven't\nadded your flat\nrequirement yet !")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.primary)
                            .lineSpacing(2)

                        Text("Tell us your budget,\nlocation & preferences and\nwe'll show you the best\nflats to move into.")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                            .lineSpacing(2)
                            .padding(.bottom, 8)

                        Button(action: onAddRequirements) {
                            HStack(spacing: 6) {
                                Image(systemName: "plus")
                                    .font(.system(size: 13, weight: .bold))
                                Text("Add requirements")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }

                        Text("Takes less than 2 minutes")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(16)

                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.07))
                                .frame(width: 105, height: 95)
                            Image(systemName: "sofa.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55)
                                .foregroundColor(Color.blue.opacity(0.45))
                        }
                        .padding(.top, 20)
                        .padding(.trailing, 14)
                        Spacer()
                    }
                }
            )
            .frame(height: 285)
    }
}

struct FlatListingRowView: View {
    let listing: FlatListing

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .frame(width: 80, height: 70)

                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28)
                    .foregroundColor(.gray.opacity(0.4))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(listing.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text(listing.location)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)

                Spacer(minLength: 6)

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
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    NavigationStack {
        FlatmatesMatchesView(onRequirementCreated: {}, openCreateOnAppear: false)
    }
}
