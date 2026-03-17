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

        let l1 = FlatmateListing(ownerID: UUID(), propertyName: "Sunset Heights", propertyType: "apartment", roomType: "single", location: "Koramangala, Bangalore", rent: 12000, genderPreference: "any", description: "Spacious 2BHK with balcony, fully furnished. Close to metro station and shopping complex.")
        l1.suitabilityScore = 87; l1.cleanlinessLevel = 4; l1.sleepSchedule = "moderate"
        l1.smokingPreference = "no"; l1.foodPreference = "any"; l1.noiseLevel = "quiet"
        
        let l2 = FlatmateListing(ownerID: UUID(), propertyName: "Green Valley PG", propertyType: "pg", roomType: "double", location: "HSR Layout, Bangalore", rent: 8500, genderPreference: "male", description: "Well-maintained PG with meals, WiFi, and laundry. Walking distance to tech parks.")
        l2.suitabilityScore = 72; l2.cleanlinessLevel = 3; l2.sleepSchedule = "early"
        l2.smokingPreference = "no"; l2.foodPreference = "veg"; l2.noiseLevel = "moderate"
        
        let l3 = FlatmateListing(ownerID: UUID(), propertyName: "Urban Nest Coliving", propertyType: "shared", roomType: "single", location: "Indiranagar, Bangalore", rent: 15000, genderPreference: "any", description: "Premium coliving space with gym, rooftop, and community events. All utilities included.")
        l3.suitabilityScore = 63; l3.cleanlinessLevel = 5; l3.sleepSchedule = "late"
        l3.smokingPreference = "no"; l3.foodPreference = "any"; l3.noiseLevel = "moderate"
        
        let l4 = FlatmateListing(ownerID: UUID(), propertyName: "Lake View Residency", propertyType: "apartment", roomType: "double", location: "Marathahalli, Bangalore", rent: 9000, genderPreference: "female", description: "Beautiful apartment overlooking the lake. Gated community with 24/7 security.")
        l4.suitabilityScore = 91; l4.cleanlinessLevel = 4; l4.sleepSchedule = "moderate"
        l4.smokingPreference = "no"; l4.foodPreference = "veg"; l4.noiseLevel = "quiet"
        
        let l5 = FlatmateListing(ownerID: UUID(), propertyName: "Palm Grove Villa", propertyType: "villa", roomType: "single", location: "Whitefield, Bangalore", rent: 18000, genderPreference: "any", description: "Luxury villa room with private bathroom, garden access, and parking. Pet friendly.")
        l5.suitabilityScore = 78; l5.cleanlinessLevel = 5; l5.sleepSchedule = "moderate"
        l5.smokingPreference = "no"; l5.petsPreference = "yes"; l5.foodPreference = "nonveg"; l5.noiseLevel = "quiet"
        
        let sampleListings = [l1, l2, l3, l4, l5]

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
