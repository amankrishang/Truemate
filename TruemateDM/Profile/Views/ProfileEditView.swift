import SwiftUI
import SwiftData

struct ProfileEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var users: [User]

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var age: String = ""

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)
    private var currentUser: User? { users.first }

    var body: some View {
        Form {
            Section("Personal Information") {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(accentColor)
                        .frame(width: 24)
                    TextField("Full Name", text: $fullName)
                }

                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(accentColor)
                        .frame(width: 24)
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                }

                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(accentColor)
                        .frame(width: 24)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }

                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(accentColor)
                        .frame(width: 24)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                }
            }

            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text("Member since")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Text(formattedDate(currentUser?.createdAt ?? Date()))
                            .font(.system(size: 14, weight: .medium))
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") { saveProfile() }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(accentColor)
            }
        }
        .onAppear { loadProfile() }
    }

    private func loadProfile() {
        guard let user = currentUser else { return }
        fullName = user.fullName
        email = user.email
        phoneNumber = user.phoneNumber
        age = "\(user.age)"
    }

    private func saveProfile() {
        guard let user = currentUser else { return }
        user.fullName = fullName
        user.email = email
        user.phoneNumber = phoneNumber
        user.age = Int(age) ?? user.age
        try? modelContext.save()
        dismiss()
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
