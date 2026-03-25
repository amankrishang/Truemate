import SwiftUI

struct BaseMatchTabView: View {
    let openFlatmatesCreateOnAppear: Bool
    @State private var hasCreatedPost = false
    @State private var hasCreatedFlatRequirement = false
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                Group {
                    if User.currentUser?.activeMode == .findFlatmates {
                        if hasCreatedFlatRequirement {
                            FlatmatesMatchesWithRequirementView()
                        } else {
                            FlatmatesMatchesView(
                                onRequirementCreated: {
                                    hasCreatedFlatRequirement = true
                                },
                                openCreateOnAppear: openFlatmatesCreateOnAppear
                            )
                        }
                    } else {
                        if hasCreatedPost {
                            MatchesWithPostView(onCreatePostSuccess: { hasCreatedPost = true })
                        } else {
                            MatchesHomeView(onCreatePostSuccess: { hasCreatedPost = true })
                        }
                    }
                }
            }
            .tabItem {
                Label("Match", systemImage: "person.2.fill")
            }
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .tag(0)

            ChatsListView()
                .tabItem {
                    Label("Chats", systemImage: "message")
                }
                .toolbarBackground(.ultraThinMaterial, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .tag(1)

            ProfileSettingsView()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
                .toolbarBackground(.ultraThinMaterial, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .tag(2)
        }
        .onReceive(NotificationCenter.default.publisher(for: .switchToChatsTab)) { _ in
            selectedTab = 1
        }
        .onReceive(NotificationCenter.default.publisher(for: .didSendMessageRequest)) { notification in
            let name = notification.userInfo?["name"] as? String ?? ""
            if !name.isEmpty {
                ChatInbox.shared.addChatIfNeeded(name: name)
            }
            selectedTab = 1
        }
    }
}

struct MatchesHomeView: View {
    var onCreatePostSuccess: () -> Void
    @State private var showCreatePost = false
    @State private var selectedProfileName = ""
    @State private var showFlatmateProfile = false

    let listings = ListingMatch.sample
    
    private var isFlatmatesMode: Bool {
        User.currentUser?.activeMode == .findFlatmates
    }

    private var emptyCardTitle: String {
        isFlatmatesMode ? "You haven't posted\nyour flat requirement\nyet !" : "You haven't\nlisted your co-living\nspace yet !"
    }

    private var emptyCardSubtitle: String {
        isFlatmatesMode ? "Share your preference once, and\nwe'll match you with\nrelevant spaces" : "Add your details once, and\nwe'll match you with your\ncompatible flatmates"
    }

    private var createButtonTitle: String {
        isFlatmatesMode ? "Create requirement" : "Create post"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Matches")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.blue)

                    Spacer()

                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 44, height: 44)
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)

                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.systemGray))
                    Text("Add requirements to unlock searches")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                    Image(systemName: "mic.fill")
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(emptyCardTitle)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.primary)
                                .lineSpacing(2)

                            Text(emptyCardSubtitle)
                                .font(.system(size: 12))
                                .foregroundColor(Color(.systemGray))
                                .lineSpacing(3)
                        }

                        Spacer()

                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemBlue).opacity(0.07))
                                .frame(width: 110, height: 90)
                            Image(systemName: "sofa.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 50)
                                .foregroundColor(.blue.opacity(0.6))
                        }
                    }

                    Button(action: { showCreatePost = true }) {
                        HStack(spacing: 8) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .semibold))
                            Text(createButtonTitle)
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .contentShape(Rectangle())

                    Text("Takes less than 2 minutes")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)

                HStack {
                    Text("Listings based on your preferences")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.horizontal)
                .padding(.top, 4)

                VStack(spacing: 0) {
                    ForEach(listings.indices, id: \.self) { index in
                        let listing = listings[index]
                        Button(action: {
                            selectedProfileName = listing.name
                            showFlatmateProfile = true
                        }) {
                            ListingRowView(listing: listing)
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())
                        if index < listings.count - 1 {
                            Divider()
                                .padding(.leading, 80)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
        .sheet(isPresented: $showFlatmateProfile) {
            NavigationStack {
                FlatmateProfileView(
                    profile: FlatmateProfile.from(name: selectedProfileName),
                    onClose: { showFlatmateProfile = false }
                )
            }
        }
        .fullScreenCover(isPresented: $showCreatePost) {
            CreatePostView(isPresented: $showCreatePost, onPostCreated: {
                onCreatePostSuccess()
            })
        }
    }
}

struct MatchesWithPostView: View {
    var onCreatePostSuccess: () -> Void
    @State private var activeSheet: MatchesWithPostSheet?
    @State private var selectedProfileName = ""
    @State private var showFlatmateProfile = false

    let flatmates = FlatmateMatch.sample
    
    private var isFlatmatesMode: Bool {
        User.currentUser?.activeMode == .findFlatmates
    }

    private var myPostTitle: String {
        isFlatmatesMode ? "My requirement" : "My post"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Matches")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.blue)
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 44, height: 44)
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)

                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.systemGray))
                    Text("Add requirements to unlock searches")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                    Image(systemName: "mic.fill")
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)

                HStack {
                    Text(myPostTitle)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: { activeSheet = .editPost }) {
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray5))
                                .frame(width: 32, height: 32)
                            Image(systemName: "pencil")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.primary)
                        }
                    }
                    Button(action: { activeSheet = .createPost }) {
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray5))
                                .frame(width: 32, height: 32)
                            Image(systemName: "plus")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 0) {
                    ZStack(alignment: .bottomLeading) {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(.systemGray4), Color(.systemGray5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 180)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 40))
                                    .foregroundColor(Color(.systemGray3))
                            )
                        LinearGradient(
                            colors: [Color.clear, Color.black.opacity(0.35)],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(height: 180)
                    }
                    .cornerRadius(14, corners: [.topLeft, .topRight])

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Looking for 2 flatmates")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.primary)
                            Spacer()
                        }

                        HStack {
                            Text("2BHK Alpha 1, Greater Noida")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.systemGray))
                            Spacer()
                            Text("₹9500/Month")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.primary)
                        }

                        HStack(spacing: 16) {
                            HStack(spacing: 5) {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                Text("Live")
                                    .font(.system(size: 13))
                                    .foregroundColor(.primary)
                            }
                            HStack(spacing: 5) {
                                Image(systemName: "eye")
                                    .font(.system(size: 13))
                                    .foregroundColor(.primary)
                                Text("120 Views")
                                    .font(.system(size: 13))
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            Text("Posted 2d ago")
                                .font(.system(size: 12))
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(14, corners: [.bottomLeft, .bottomRight])
                }
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal)

                Button(action: { activeSheet = .allFlatmates }) {
                    HStack {
                        Text("All flatmates")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13))
                            .foregroundColor(Color(.systemGray))
                    }
                    .padding(.horizontal)
                }

                VStack(spacing: 12) {
                    ForEach(flatmates) { match in
                        Button(action: {
                            selectedProfileName = match.name
                            showFlatmateProfile = true
                        }) {
                            FlatmateCardView(match: match)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
        .sheet(isPresented: $showFlatmateProfile) {
            NavigationStack {
                FlatmateProfileView(
                    profile: FlatmateProfile.from(name: selectedProfileName),
                    onClose: { showFlatmateProfile = false }
                )
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .createPost:
                CreatePostView(
                    isPresented: Binding(
                        get: { activeSheet == .createPost },
                        set: { if !$0 { activeSheet = nil } }
                    ),
                    onPostCreated: {
                        onCreatePostSuccess()
                        activeSheet = nil
                    }
                )
            case .allFlatmates:
                AllFlatmatesView(
                    isPresented: Binding(
                        get: { activeSheet == .allFlatmates },
                        set: { if !$0 { activeSheet = nil } }
                    )
                )
            case .editPost:
                EditPostView(
                    isPresented: Binding(
                        get: { activeSheet == .editPost },
                        set: { if !$0 { activeSheet = nil } }
                    )
                )
            }
        }
    }
}

enum MatchesWithPostSheet: String, Identifiable {
    case createPost
    case allFlatmates
    case editPost

    var id: String { rawValue }
}

struct ListingRowView: View {
    let listing: ListingMatch

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray5))
                    .frame(width: 64, height: 64)
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .foregroundColor(Color(.systemGray2))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(listing.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                Text(listing.lookingFor)
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemGray))

                Spacer().frame(height: 4)

                HStack {
                    Text("₹\(listing.pricePerMonth)/Month")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.primary)
                    Spacer()
                    Text(listing.timeAgo)
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }
}

struct FlatmateCardView: View {
    let match: FlatmateMatch

    var matchColor: Color {
        match.matchPercent >= 70 ? Color.green.opacity(0.15) : Color(.systemGray5)
    }

    var matchTextColor: Color {
        match.matchPercent >= 70 ? Color.green : Color(.systemGray)
    }

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray5))
                    .frame(width: 72, height: 80)
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .foregroundColor(Color(.systemGray3))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(match.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                Text(match.lookingFor)
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemGray))

                Text("\(match.matchPercent)% Match")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(matchTextColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(matchColor)
                    .cornerRadius(20)

                Spacer().frame(height: 2)

                HStack {
                    Text("₹\(match.pricePerMonth)/Month")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.primary)
                    Spacer()
                    Text(match.timeAgo)
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                }
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(14)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    BaseMatchTabView(openFlatmatesCreateOnAppear: false)
}
