import SwiftUI
import SwiftData

struct LookingForView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]

    @State private var selected: UserMode? = nil

    var onNext: (() -> Void)? = nil

    private var currentUser: User? { users.first }

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: geo.size.height * 0.32)

                Text("What are you\nlooking for?")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color(red: 0.15, green: 0.25, blue: 0.95))
                    .lineSpacing(2)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 14)

                Text("We want to know if you are\nlooking for a co-living space or\nflatmate?")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .lineSpacing(4)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 80)

                HStack(spacing: 20) {
                    OptionButton(
                        title: "Co-living Space",
                        isSelected: selected == .findFlats
                    ) {
                        selectMode(.findFlats)
                        onNext?()
                    }

                    OptionButton(
                        title: "Flatmates",
                        isSelected: selected == .findFlatmates
                    ) {
                        selectMode(.findFlatmates)
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            selected = currentUser?.activeMode
        }
        .background(Color.white.ignoresSafeArea())
    }

    private func selectMode(_ mode: UserMode) {
        selected = mode
        guard let user = currentUser else { return }
        user.activeMode = mode
        user.isOnboardingComplete = false
        try? modelContext.save()
    }
}

struct OptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 26)
                .padding(.vertical, 18)
                .background(
                    isSelected
                    ? Color(red: 0.10, green: 0.20, blue: 0.85)
                    : Color(red: 0.22, green: 0.35, blue: 0.95)
                )
                .cornerRadius(50)
        }
        .scaleEffect(isSelected ? 0.96 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}

#Preview {
    LookingForView()
}
