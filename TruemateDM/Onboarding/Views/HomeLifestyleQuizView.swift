import SwiftUI
import SwiftData

struct HomeLifestyleQuizView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Query private var seekerProfiles: [FlatSeekerProfile]

    @State private var selectedOption: String? = nil

    var onNext: (() -> Void)? = nil

    let options = [
        "Mostly quiet + prefer personal space",
        "Some noise is fine",
        "I sleep anywhere",
        "I use headphones while sleeping"
    ]

    private var currentUser: User? { users.first }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(white: 0.88))
                        .frame(height: 4)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 0.22, green: 0.42, blue: 0.98))
                        .frame(width: geo.size.width * 0.05, height: 4)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 20)
            .padding(.top, 16)

            Text("What best describes your home lifestyle?")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(Color(red: 0.22, green: 0.42, blue: 0.98))
                .padding(.horizontal, 20)
                .padding(.top, 32)

            Text("Select one")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.top, 8)

            VStack(spacing: 14) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        selectedOption == option
                                            ? Color(red: 0.22, green: 0.42, blue: 0.98)
                                            : Color(red: 0.22, green: 0.42, blue: 0.98).opacity(0.4),
                                        lineWidth: selectedOption == option ? 2 : 1
                                    )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)

            Spacer()

            HStack {
                Spacer()
                Button(action: handleNext) {
                    Text("Next")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(Color(red: 0.22, green: 0.42, blue: 0.98))
                        .clipShape(Capsule())
                }
                .disabled(selectedOption == nil)
                .opacity(selectedOption == nil ? 0.5 : 1)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
    }

    private func handleNext() {
        guard let user = currentUser, let option = selectedOption else { return }

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

        profile.noiseLevel = mapNoiseLevel(from: option)

        try? modelContext.save()
        onNext?()
    }

    private func mapNoiseLevel(from option: String) -> String {
        switch option {
        case "Mostly quiet + prefer personal space":
            return "quiet"
        case "Some noise is fine":
            return "moderate"
        case "I sleep anywhere":
            return "moderate"
        case "I use headphones while sleeping":
            return "noisy"
        default:
            return "moderate"
        }
    }
}

#Preview {
    HomeLifestyleQuizView()
}
