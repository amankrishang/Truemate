import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Query private var listings: [FlatmateListing]
    @Query private var seekerPosts: [FlatSeekerPost]
    @Query private var savedListings: [SavedListing]

    @State private var showOnboarding = false
    @State private var showCreateRequirement = false
    @State private var showSavedListings = false

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    private var currentUser: User? { users.first }

    private var hasRequirement: Bool {
        guard let user = currentUser else { return false }
        switch user.activeMode {
        case .findFlats:
            return seekerPosts.contains { $0.userID == user.id }
        case .findFlatmates:
            return listings.contains { $0.ownerID == user.id }
        case .both:
            return seekerPosts.contains { $0.userID == user.id } ||
                   listings.contains { $0.ownerID == user.id }
        }
    }

    private var availableListings: [FlatmateListing] {
        guard let user = currentUser else { return [] }
        return listings.filter { $0.ownerID != user.id }
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            if currentUser == nil || !(currentUser?.isOnboardingComplete ?? false) {
                OnboardingProfileSetupView(isOnboardingComplete: $showOnboarding)
                    .onChange(of: showOnboarding) { _, newValue in
                        if newValue {
                            seedSampleData()
                        }
                    }
            } else if !hasRequirement {
                EmptyHomeView(onCreateAction: { showCreateRequirement = true })
                    .navigationTitle(modeTitle)
                    .toolbar { homeToolbarItems }
            } else if availableListings.isEmpty {
                noMatchesView
                    .navigationTitle(modeTitle)
                    .toolbar { homeToolbarItems }
            } else {
                ListingsView(listings: availableListings, currentUserID: currentUser?.id ?? UUID())
                    .navigationTitle(modeTitle)
                    .toolbar { homeToolbarItems }
            }
        }
        .sheet(isPresented: $showCreateRequirement) {
            NavigationStack {
                CreateRequirementView()
            }
        }
        .sheet(isPresented: $showSavedListings) {
            NavigationStack {
                SavedListingsView()
            }
        }
    }

    private var modeTitle: String {
        guard let user = currentUser else { return "Truemate" }
        return user.activeMode.displayName
    }

    @ToolbarContentBuilder
    private var homeToolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack(spacing: 6) {
                Image(systemName: currentUser?.activeMode.icon ?? "house.fill")
                    .foregroundColor(accentColor)
                Text("Truemate")
                    .font(.system(size: 20, weight: .bold))
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 16) {
                Button(action: { showSavedListings = true }) {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.secondary)
                }
                Button(action: { showCreateRequirement = true }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(accentColor)
                }
            }
        }
    }

    private var noMatchesView: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 56))
                .foregroundColor(.secondary.opacity(0.4))
            Text("No Matches Yet")
                .font(.system(size: 22, weight: .bold))
            Text("We're looking for the best matches for you.\nCheck back soon!")
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }

    // MARK: - Seed Sample Data
    private func seedSampleData() {
        guard let user = currentUser else { return }

        let sampleListings = [
            FlatmateListing(ownerID: UUID(), propertyType: "apartment", roomType: "single",
                           propertyName: "Sunset Heights", location: "Koramangala, Bangalore",
                           rent: 12000, genderPreference: "any",
                           listingDescription: "Spacious 2BHK with balcony, fully furnished. Close to metro station and shopping complex.",
                           suitabilityScore: 87, cleanlinessLevel: 4, sleepSchedule: "moderate",
                           smokingPreference: "no", foodPreference: "any", noiseLevel: "quiet"),
            FlatmateListing(ownerID: UUID(), propertyType: "pg", roomType: "double",
                           propertyName: "Green Valley PG", location: "HSR Layout, Bangalore",
                           rent: 8500, genderPreference: "male",
                           listingDescription: "Well-maintained PG with meals, WiFi, and laundry. Walking distance to tech parks.",
                           suitabilityScore: 72, cleanlinessLevel: 3, sleepSchedule: "early",
                           smokingPreference: "no", foodPreference: "veg", noiseLevel: "moderate"),
            FlatmateListing(ownerID: UUID(), propertyType: "shared", roomType: "single",
                           propertyName: "Urban Nest Coliving", location: "Indiranagar, Bangalore",
                           rent: 15000, genderPreference: "any",
                           listingDescription: "Premium coliving space with gym, rooftop, and community events. All utilities included.",
                           suitabilityScore: 63, cleanlinessLevel: 5, sleepSchedule: "late",
                           smokingPreference: "no", foodPreference: "any", noiseLevel: "moderate"),
            FlatmateListing(ownerID: UUID(), propertyType: "apartment", roomType: "double",
                           propertyName: "Lake View Residency", location: "Marathahalli, Bangalore",
                           rent: 9000, genderPreference: "female",
                           listingDescription: "Beautiful apartment overlooking the lake. Gated community with 24/7 security.",
                           suitabilityScore: 91, cleanlinessLevel: 4, sleepSchedule: "moderate",
                           smokingPreference: "no", foodPreference: "veg", noiseLevel: "quiet"),
            FlatmateListing(ownerID: UUID(), propertyType: "villa", roomType: "single",
                           propertyName: "Palm Grove Villa", location: "Whitefield, Bangalore",
                           rent: 18000, genderPreference: "any",
                           listingDescription: "Luxury villa room with private bathroom, garden access, and parking. Pet friendly.",
                           suitabilityScore: 78, cleanlinessLevel: 5, sleepSchedule: "moderate",
                           smokingPreference: "no", petsPreference: "yes", foodPreference: "nonveg", noiseLevel: "quiet")
        ]

        for listing in sampleListings {
            modelContext.insert(listing)
        }

        let seekerPost = FlatSeekerPost(
            userID: user.id,
            preferredLocation: "Bangalore",
            budget: 15000,
            moveInDate: Date().addingTimeInterval(30 * 24 * 3600),
            details: "Looking for a clean, peaceful flat near tech parks"
        )
        modelContext.insert(seekerPost)

        try? modelContext.save()
    }
}
