import SwiftUI

struct LookingForView: View {
    @State private var selected: UserMode? = nil

    var onNext: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 260)

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
                    onNext?()
                }

                Spacer()
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .onAppear {
            selected = User.currentUser?.activeMode
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.ignoresSafeArea())
    }

    private func selectMode(_ mode: UserMode) {
        selected = mode
        guard let user = User.currentUser else { return }
        user.activeMode = mode
        user.isOnboardingComplete = false
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
    }
}

#Preview {
    LookingForView()
}
