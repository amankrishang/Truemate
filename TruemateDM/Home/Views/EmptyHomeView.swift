import SwiftUI

struct EmptyHomeView: View {
    var onCreateAction: () -> Void
    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            ZStack {
                Circle()
                    .fill(accentColor.opacity(0.08))
                    .frame(width: 160, height: 160)
                Circle()
                    .fill(accentColor.opacity(0.12))
                    .frame(width: 110, height: 110)
                Image(systemName: "doc.text.magnifyingglass")
                    .font(.system(size: 48))
                    .foregroundColor(accentColor)
            }

            VStack(spacing: 10) {
                Text("No Requirements Yet")
                    .font(.system(size: 24, weight: .bold))
                Text("Create your first requirement to start\nfinding your perfect match.")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button(action: onCreateAction) {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                    Text("Create Requirement")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(accentColor)
                .cornerRadius(14)
            }

            Spacer()
        }
        .padding()
    }
}
