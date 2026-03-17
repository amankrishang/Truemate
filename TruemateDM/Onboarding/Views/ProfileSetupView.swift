import SwiftUI
import SwiftData

struct OnboardingProfileSetupView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var age: String = "25"
    @State private var selectedMode: UserMode = .both

    // Lifestyle
    @State private var cleanlinessLevel: Double = 3
    @State private var sleepSchedule: String = "moderate"
    @State private var smokingPreference: String = "no"
    @State private var foodPreference: String = "any"

    @State private var currentStep: Int = 0
    @Binding var isOnboardingComplete: Bool

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    var body: some View {
        VStack(spacing: 0) {
            // Progress bar
            ProgressView(value: Double(currentStep + 1), total: 3)
                .tint(accentColor)
                .padding(.horizontal, 24)
                .padding(.top, 16)

            TabView(selection: $currentStep) {
                // Step 1: Basic Info
                basicInfoStep
                    .tag(0)

                // Step 2: Mode Selection
                modeSelectionStep
                    .tag(1)

                // Step 3: Lifestyle
                lifestyleStep
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentStep)

            // Navigation buttons
            HStack(spacing: 16) {
                if currentStep > 0 {
                    Button(action: { withAnimation { currentStep -= 1 } }) {
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(.systemGray6))
                            .cornerRadius(14)
                    }
                }

                Button(action: {
                    if currentStep < 2 {
                        withAnimation { currentStep += 1 }
                    } else {
                        saveProfile()
                    }
                }) {
                    Text(currentStep == 2 ? "Get Started" : "Next")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(accentColor)
                        .cornerRadius(14)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
    }

    // MARK: - Step 1: Basic Info
    private var basicInfoStep: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome to Truemate")
                        .font(.system(size: 28, weight: .bold))
                    Text("Let's set up your profile")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 16) {
                    onboardingTextField(title: "Full Name", text: $fullName, icon: "person.fill")
                    onboardingTextField(title: "Email", text: $email, icon: "envelope.fill")
                    onboardingTextField(title: "Phone Number", text: $phoneNumber, icon: "phone.fill")
                    onboardingTextField(title: "Age", text: $age, icon: "calendar")
                }
            }
            .padding(24)
        }
    }

    // MARK: - Step 2: Mode Selection
    private var modeSelectionStep: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What are you looking for?")
                        .font(.system(size: 28, weight: .bold))
                    Text("You can change this anytime")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 12) {
                    ForEach(UserMode.allCases, id: \.self) { mode in
                        modeCard(mode: mode)
                    }
                }
            }
            .padding(24)
        }
    }

    // MARK: - Step 3: Lifestyle
    private var lifestyleStep: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Lifestyle")
                        .font(.system(size: 28, weight: .bold))
                    Text("Helps us find better matches")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cleanliness Level")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                        HStack {
                            Text("Relaxed")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                            Slider(value: $cleanlinessLevel, in: 1...5, step: 1)
                                .tint(accentColor)
                            Text("Spotless")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                    }

                    lifestylePicker(title: "Sleep Schedule", selection: $sleepSchedule,
                                    options: ["early": "Early Bird 🌅", "moderate": "Moderate ⏰", "late": "Night Owl 🌙"])

                    lifestylePicker(title: "Smoking", selection: $smokingPreference,
                                    options: ["no": "No 🚭", "occasionally": "Occasionally", "yes": "Yes 🚬"])

                    lifestylePicker(title: "Food Preference", selection: $foodPreference,
                                    options: ["veg": "Vegetarian 🥗", "nonveg": "Non-Veg 🍖", "vegan": "Vegan 🌱", "any": "Any 🍽️"])
                }
            }
            .padding(24)
        }
    }

    // MARK: - Components
    private func onboardingTextField(title: String, text: Binding<String>, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.secondary)
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(accentColor)
                    .frame(width: 20)
                TextField(title, text: text)
                    .font(.system(size: 16))
            }
            .padding(14)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }

    private func modeCard(mode: UserMode) -> some View {
        Button(action: { selectedMode = mode }) {
            HStack(spacing: 16) {
                Image(systemName: mode.icon)
                    .font(.system(size: 24))
                    .foregroundColor(selectedMode == mode ? .white : accentColor)
                    .frame(width: 48, height: 48)
                    .background(selectedMode == mode ? accentColor : accentColor.opacity(0.1))
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 4) {
                    Text(mode.displayName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(modeDescription(mode))
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: selectedMode == mode ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(selectedMode == mode ? accentColor : .secondary)
                    .font(.system(size: 22))
            }
            .padding(16)
            .background(selectedMode == mode ? accentColor.opacity(0.08) : Color(.systemGray6))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(selectedMode == mode ? accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }

    private func lifestylePicker(title: String, selection: Binding<String>, options: [String: String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)

            HStack(spacing: 8) {
                ForEach(Array(options.keys.sorted()), id: \.self) { key in
                    Button(action: { selection.wrappedValue = key }) {
                        Text(options[key] ?? key)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(selection.wrappedValue == key ? .white : .primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(selection.wrappedValue == key ? accentColor : Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func modeDescription(_ mode: UserMode) -> String {
        switch mode {
        case .findFlats: return "Browse flats and co-living spaces"
        case .findFlatmates: return "Find people to share your space"
        case .both: return "Do both — find flats and flatmates"
        }
    }

    // MARK: - Save
    private func saveProfile() {
        let user: User
        if let existingUser = users.first {
            user = existingUser
        } else {
            user = User()
            modelContext.insert(user)
        }
        user.fullName = fullName
        user.email = email
        user.phoneNumber = phoneNumber
        user.age = Int(age) ?? 25
        user.activeMode = selectedMode
        user.canFindFlats = selectedMode == .findFlats || selectedMode == .both
        user.canFindFlatmates = selectedMode == .findFlatmates || selectedMode == .both
        user.isOnboardingComplete = true

        let seekerProfile = FlatSeekerProfile(
            userID: user.id,
            fullName: fullName,
            email: email,
            phoneNumber: phoneNumber,
            age: Int(age) ?? 25,
            cleanlinessLevel: Int(cleanlinessLevel),
            sleepSchedule: sleepSchedule,
            smokingPreference: smokingPreference,
            foodPreference: foodPreference
        )
        modelContext.insert(seekerProfile)

        try? modelContext.save()
        isOnboardingComplete = true
    }
}
