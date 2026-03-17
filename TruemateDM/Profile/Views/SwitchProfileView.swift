import SwiftUI
import SwiftData

struct SwitchProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var users: [User]

    @State private var selectedMode: UserMode = .both

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)
    private var currentUser: User? { users.first }

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("Switch Mode")
                    .font(.system(size: 24, weight: .bold))
                Text("Choose how you want to use Truemate")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 16)

            VStack(spacing: 12) {
                ForEach(UserMode.allCases, id: \.self) { mode in
                    modeOption(mode)
                }
            }
            .padding(.horizontal, 20)

            Spacer()

            // Current mode indicator
            if let user = currentUser {
                HStack(spacing: 8) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.secondary)
                    Text("Currently set to: \(user.activeMode.displayName)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }

            Button(action: saveMode) {
                Text("Apply Changes")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(accentColor)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .navigationTitle("Switch Mode")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Cancel") { dismiss() }
                    .foregroundColor(accentColor)
            }
        }
        .onAppear {
            selectedMode = currentUser?.activeMode ?? .both
        }
    }

    private func modeOption(_ mode: UserMode) -> some View {
        Button(action: { withAnimation(.spring(response: 0.3)) { selectedMode = mode } }) {
            HStack(spacing: 16) {
                Image(systemName: mode.icon)
                    .font(.system(size: 24))
                    .foregroundColor(selectedMode == mode ? .white : accentColor)
                    .frame(width: 52, height: 52)
                    .background(selectedMode == mode ? accentColor : accentColor.opacity(0.1))
                    .cornerRadius(14)

                VStack(alignment: .leading, spacing: 4) {
                    Text(mode.displayName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(modeDescription(mode))
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

                Spacer()

                Image(systemName: selectedMode == mode ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(selectedMode == mode ? accentColor : Color(.systemGray4))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(selectedMode == mode ? accentColor.opacity(0.08) : Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(selectedMode == mode ? accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }

    private func modeDescription(_ mode: UserMode) -> String {
        switch mode {
        case .findFlats: return "Browse available flats and co-living spaces in your area"
        case .findFlatmates: return "List your space and find compatible flatmates"
        case .both: return "Search for flats and list your space simultaneously"
        }
    }

    private func saveMode() {
        guard let user = currentUser else { return }
        user.activeMode = selectedMode
        user.canFindFlats = selectedMode == .findFlats || selectedMode == .both
        user.canFindFlatmates = selectedMode == .findFlatmates || selectedMode == .both
        try? modelContext.save()
        dismiss()
    }
}
