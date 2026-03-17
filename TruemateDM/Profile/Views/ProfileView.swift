import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Query private var seekerProfiles: [FlatSeekerProfile]
    @Query private var ownerProfiles: [FlatOwnerProfile]

    @State private var showEditProfile = false
    @State private var showSwitchMode = false

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)
    private var currentUser: User? { users.first }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Header
                profileHeader

                // Mode Card
                modeCard

                // Stats Card
                statsCard

                // Menu Items
                menuSection

                // Danger Zone
                dangerSection
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $showEditProfile) {
            NavigationStack {
                ProfileEditView()
            }
        }
        .sheet(isPresented: $showSwitchMode) {
            NavigationStack {
                SwitchProfileView()
            }
        }
    }

    // MARK: - Profile Header
    private var profileHeader: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [accentColor, accentColor.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 90, height: 90)
                Text(initials)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }

            VStack(spacing: 4) {
                Text(currentUser?.fullName.isEmpty == false ? currentUser!.fullName : "Set up your profile")
                    .font(.system(size: 22, weight: .bold))
                if let email = currentUser?.email, !email.isEmpty {
                    Text(email)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }

            Button(action: { showEditProfile = true }) {
                Text("Edit Profile")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(accentColor)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(accentColor.opacity(0.1))
                    .cornerRadius(20)
            }
        }
        .padding(.top, 16)
    }

    // MARK: - Mode Card
    private var modeCard: some View {
        Button(action: { showSwitchMode = true }) {
            HStack(spacing: 14) {
                Image(systemName: currentUser?.activeMode.icon ?? "arrow.left.arrow.right")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .frame(width: 46, height: 46)
                    .background(accentColor)
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 3) {
                    Text("Current Mode")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    Text(currentUser?.activeMode.displayName ?? "Not set")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(Color(.systemGray6))
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Stats
    private var statsCard: some View {
        HStack(spacing: 0) {
            statItem(value: "\(seekerProfiles.count + ownerProfiles.count)", label: "Profiles", icon: "person.crop.rectangle.stack.fill")
            Divider().frame(height: 40)
            statItem(value: "\(currentUser?.age ?? 0)", label: "Age", icon: "calendar")
            Divider().frame(height: 40)
            statItem(value: currentUser?.isOnboardingComplete == true ? "✓" : "✗", label: "Verified", icon: "checkmark.seal.fill")
        }
        .padding(.vertical, 16)
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }

    private func statItem(value: String, label: String, icon: String) -> some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(accentColor)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Menu Section
    private var menuSection: some View {
        VStack(spacing: 0) {
            menuItem(icon: "person.text.rectangle", title: "Personal Information", action: { showEditProfile = true })
            Divider().padding(.leading, 52)
            menuItem(icon: "arrow.triangle.swap", title: "Switch Mode", action: { showSwitchMode = true })
            Divider().padding(.leading, 52)
            menuItem(icon: "bell.fill", title: "Notifications", action: {})
            Divider().padding(.leading, 52)
            menuItem(icon: "shield.checkered", title: "Privacy & Security", action: {})
            Divider().padding(.leading, 52)
            menuItem(icon: "questionmark.circle.fill", title: "Help & Support", action: {})
        }
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }

    private func menuItem(icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .foregroundColor(accentColor)
                    .frame(width: 24)
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Danger Zone
    private var dangerSection: some View {
        VStack(spacing: 0) {
            Button(action: {}) {
                HStack(spacing: 14) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                        .frame(width: 24)
                    Text("Log Out")
                        .font(.system(size: 15))
                        .foregroundColor(.red)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
            }
            .buttonStyle(.plain)
        }
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }

    private var initials: String {
        guard let name = currentUser?.fullName, !name.isEmpty else { return "?" }
        let parts = name.split(separator: " ")
        let first = parts.first?.prefix(1) ?? "?"
        let second = parts.count > 1 ? parts[1].prefix(1) : ""
        return "\(first)\(second)".uppercased()
    }
}
