import SwiftUI

struct ProfileSettingsView: View {
    @State private var showAccountManagement = false
    @State private var showSecurityPrivacy = false
    @State private var showAppPreferences = false
    
    private var userName: String {
        let name = User.currentUser?.fullName.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return name.isEmpty ? "Profile" : name
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Profile")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 20)

                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 2)
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .foregroundColor(Color(.systemGray3))
                    }

                    HStack(spacing: 4) {
                        Text(userName)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 28)

                settingsSection(title: "More Controls", rows: [
                    SettingsRow(icon: "gearshape", iconColor: .gray, label: "Account Management", showChevron: true, action: { showAccountManagement = true }),
                    SettingsRow(icon: "lock.fill", iconColor: .blue, label: "Security & Privacy", showChevron: true, action: { showSecurityPrivacy = true }),
                    SettingsRow(icon: "slider.horizontal.3", iconColor: .blue, label: "App Preferences", showChevron: true, action: { showAppPreferences = true })
                ])

                settingsSection(title: "Support", rows: [
                    SettingsRow(icon: "plus.circle.fill", iconColor: .blue, label: "Suggest new features", showChevron: true, action: {}),
                    SettingsRow(icon: "info.circle.fill", iconColor: .blue, label: "About TrueMate", showChevron: true, action: {})
                ])

                settingsSection(title: "Other", rows: [
                    SettingsRow(icon: "square.and.arrow.up", iconColor: .blue, label: "Share our app", showChevron: false, action: {}),
                    SettingsRow(icon: "doc.fill", iconColor: .blue, label: "Legal & Compliance", showChevron: true, action: {})
                ])

                HStack(spacing: 4) {
                    Text("Made with")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                    Image(systemName: "heart.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
                .padding(.bottom, 32)
            }
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
        .sheet(isPresented: $showAccountManagement) {
            AccountManagementView(isPresented: $showAccountManagement)
        }
        .sheet(isPresented: $showSecurityPrivacy) {
            SecurityPrivacyView(isPresented: $showSecurityPrivacy)
        }
        .sheet(isPresented: $showAppPreferences) {
            PreferencesView(isPresented: $showAppPreferences)
        }
    }
    
    private func settingsSection(title: String, rows: [SettingsRow]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(Color(.systemGray))
                .padding(.horizontal, 16)
                .padding(.bottom, 6)

            VStack(spacing: 0) {
                ForEach(rows.indices, id: \.self) { index in
                    let row = rows[index]
                    Button(action: row.action) {
                        HStack(spacing: 14) {
                            Image(systemName: row.icon)
                                .font(.system(size: 17))
                                .foregroundColor(row.iconColor)
                                .frame(width: 28)

                            Text(row.label)
                                .font(.system(size: 15))
                                .foregroundColor(.primary)

                            Spacer()

                            if row.showChevron {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(.systemGray3))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 15)
                    }

                    if index < rows.count - 1 {
                        Divider()
                            .padding(.leading, 58)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(14)
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    ProfileSettingsView()
}
