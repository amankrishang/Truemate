import SwiftUI

struct AccountManagementView: View {
    @Binding var isPresented: Bool
    @State private var showDeleteConfirmation = false
    @State private var showPersonalInformation = false
    @State private var showPreferences = false
    
    private var hasCurrentUser: Bool {
        User.currentUser != nil
    }
    
    private var accountRows: [SettingsRow] {
        [
            SettingsRow(
                icon: "person.circle.fill",
                iconColor: .blue,
                label: "Personal Information",
                showChevron: true,
                action: {
                    if hasCurrentUser {
                        showPersonalInformation = true
                    }
                }
            ),
            SettingsRow(
                icon: "house.fill",
                iconColor: .blue,
                label: "Preferences",
                showChevron: true,
                action: {
                    if hasCurrentUser {
                        showPreferences = true
                    }
                }
            )
        ]
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { isPresented = false }) {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 36, height: 36)
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }

                Spacer()

                Text("Account Management")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Circle()
                    .fill(Color.clear)
                    .frame(width: 36, height: 36)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        accountMenuRow(accountRows[0])
                        Divider().padding(.leading, 54)
                        accountMenuRow(accountRows[1])
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                    Spacer().frame(height: 280)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.red)

                            Text("Delete Account")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)

                            Spacer()

                            Button(action: {
                                if hasCurrentUser {
                                    showDeleteConfirmation = true
                                }
                            }) {
                                Text("Delete")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(16)

                        Text("Deleting your account permanently removes your data from Truemate and you will never be able to log in back to same account.")
                            .font(.system(size: 12))
                            .foregroundColor(Color(.systemGray))
                            .padding(.horizontal, 4)
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 4) {
                        Text("Truemate • Version 1.0")
                            .font(.system(size: 13))
                            .foregroundColor(Color(.systemGray))

                        HStack(spacing: 4) {
                            Text("Made with")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.systemGray))
                            Image(systemName: "heart.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.red)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 48)
                    .padding(.bottom, 32)
                }
            }
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
        .sheet(isPresented: $showPersonalInformation) {
            PersonalInformationView(isPresented: $showPersonalInformation)
        }
        .sheet(isPresented: $showPreferences) {
            PreferencesView(isPresented: $showPreferences)
        }
        .confirmationDialog(
            "Delete Account",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                guard let current = User.currentUser else { return }
                User.allUsers.removeAll { $0.id == current.id }
                User.currentUser = nil
                isPresented = false
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action is permanent and cannot be undone.")
        }
    }
    
    private func accountMenuRow(_ row: SettingsRow) -> some View {
        Button(action: row.action) {
            HStack(spacing: 14) {
                Image(systemName: row.icon)
                    .font(.system(size: 20))
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
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    AccountManagementView(isPresented: .constant(true))
}
