import SwiftUI
import SwiftData

struct ProfileSetupView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Query private var seekerProfiles: [FlatSeekerProfile]

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var age: String = ""

    @State private var address: String = ""
    @State private var country: String = ""
    @State private var postalCode: String = ""
    @State private var city: String = ""
    @State private var aadhaarVerified: Bool = false

    var onContinue: (() -> Void)? = nil

    private var currentUser: User? { users.first }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Profile Setup")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                    .padding(.top, 16)

                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray4))
                            .frame(width: 100, height: 100)

                        Image(systemName: "camera")
                            .font(.system(size: 30))
                            .foregroundColor(Color(.systemGray2))
                    }

                    Text("Add Profile Photo")
                        .font(.system(size: 15))
                        .foregroundColor(Color(.systemGray))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 0) {
                    Text("Personal Information")
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.horizontal)
                        .padding(.bottom, 8)

                    VStack(spacing: 0) {
                        ClearableTextField(placeholder: "Full Name", text: $fullName, showClear: true)
                        Divider().padding(.leading)
                        PlainTextField(placeholder: "Email", text: $email)
                        Divider().padding(.leading)
                        PlainTextField(placeholder: "Phone Number", text: $phoneNumber, keyboardType: .phonePad)
                        Divider().padding(.leading)
                        PlainTextField(placeholder: "Age", text: $age, keyboardType: .numberPad)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Property location")
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.horizontal)
                        .padding(.bottom, 8)

                    VStack(spacing: 0) {
                        ClearableTextField(placeholder: "Enter your address", text: $address, showClear: true)
                        Divider().padding(.leading)
                        PlainTextField(placeholder: "Enter your country", text: $country)
                        Divider().padding(.leading)
                        PlainTextField(placeholder: "Enter your postal code", text: $postalCode, keyboardType: .numberPad)
                        Divider().padding(.leading)
                        PlainTextField(placeholder: "Enter your city", text: $city)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                Button(action: {
                    aadhaarVerified.toggle()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: aadhaarVerified ? "checkmark.shield.fill" : "checkmark.shield")
                            .font(.system(size: 16))
                        Text("Verify Aadhaar via DigiLocker")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                VStack(spacing: 6) {
                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Image(systemName: "rotate.3d")
                                .font(.system(size: 16))
                            Text("Upload AR model of flat")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                    }

                    Text("Verification helps build trust and improves your match quality.")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                        .padding(.horizontal, 4)
                }
                .padding(.horizontal)

                Button(action: saveProfile) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
        }
        .onAppear(perform: loadData)
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }

    private func loadData() {
        guard let user = currentUser else { return }

        fullName = user.fullName
        email = user.email
        phoneNumber = user.phoneNumber
        age = "\(user.age)"

        if let profile = seekerProfiles.first(where: { $0.userID == user.id }) {
            address = profile.address
            postalCode = profile.postalCode
            city = profile.city
            aadhaarVerified = profile.aadhaarVerified
        }
    }

    private func saveProfile() {
        guard let user = currentUser else { return }

        user.fullName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        user.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        user.phoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        user.age = Int(age) ?? user.age
        user.isOnboardingComplete = true

        let profile: FlatSeekerProfile
        if let existing = seekerProfiles.first(where: { $0.userID == user.id }) {
            profile = existing
        } else {
            let created = FlatSeekerProfile(
                userID: user.id,
                fullName: user.fullName,
                email: user.email,
                phoneNumber: user.phoneNumber,
                age: user.age
            )
            modelContext.insert(created)
            profile = created
        }

        profile.fullName = user.fullName
        profile.email = user.email
        profile.phoneNumber = user.phoneNumber
        profile.age = user.age
        profile.address = address.trimmingCharacters(in: .whitespacesAndNewlines)
        profile.city = city.trimmingCharacters(in: .whitespacesAndNewlines)
        profile.postalCode = postalCode.trimmingCharacters(in: .whitespacesAndNewlines)
        profile.aadhaarVerified = aadhaarVerified

        if !country.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            profile.address = [profile.address, country.trimmingCharacters(in: .whitespacesAndNewlines)]
                .filter { !$0.isEmpty }
                .joined(separator: ", ")
        }

        try? modelContext.save()
        onContinue?()
    }
}

struct ClearableTextField: View {
    let placeholder: String
    @Binding var text: String
    var showClear: Bool = false

    var body: some View {
        HStack {
            Text(placeholder)
                .foregroundColor(Color(.systemGray))
                .font(.system(size: 15))

            Spacer()

            TextField("", text: $text)
                .multilineTextAlignment(.trailing)
                .font(.system(size: 15))
                .foregroundColor(.primary)

            if showClear && !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(.systemGray3))
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

struct PlainTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 15))
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .keyboardType(keyboardType)
    }
}

#Preview {
    ProfileSetupView()
}
