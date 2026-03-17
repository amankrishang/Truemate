import SwiftUI
import SwiftData

@main
struct TruemateApp: App {

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [
            User.self,
            FlatSeekerProfile.self,
            FlatOwnerProfile.self,
            FlatmateListing.self,
            FlatSeekerPost.self,
            SavedListing.self,
            MatchRequest.self,
            Message.self
        ])
    }
}
