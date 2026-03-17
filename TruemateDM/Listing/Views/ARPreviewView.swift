import SwiftUI

struct ARPreviewView: View {
    @Environment(\.dismiss) private var dismiss
    var propertyName: String

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        LinearGradient(
                            colors: [accentColor.opacity(0.1), accentColor.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 300)
                    .padding(.horizontal, 32)

                VStack(spacing: 16) {
                    Image(systemName: "arkit")
                        .font(.system(size: 64))
                        .foregroundColor(accentColor)

                    Text("AR Preview")
                        .font(.system(size: 22, weight: .bold))

                    Text("Point your camera at a flat surface\nto preview \(propertyName)")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }

            Text("Coming Soon")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.secondary)

            Text("AR room preview will allow you to\nvisualize the space before visiting.")
                .font(.system(size: 14))
                .foregroundColor(.secondary.opacity(0.7))
                .multilineTextAlignment(.center)

            Spacer()
        }
        .navigationTitle("AR Preview")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") { dismiss() }
                    .foregroundColor(accentColor)
            }
        }
    }
}
