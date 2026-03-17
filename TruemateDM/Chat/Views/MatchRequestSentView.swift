import SwiftUI

struct MatchRequestSentView: View {
    @Environment(\.dismiss) private var dismiss
    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 140, height: 140)
                Circle()
                    .fill(Color.green.opacity(0.15))
                    .frame(width: 100, height: 100)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(.green)
            }

            VStack(spacing: 10) {
                Text("Request Sent! 🎉")
                    .font(.system(size: 26, weight: .bold))
                Text("Your match request has been sent.\nYou'll be notified when they respond.")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.orange)
                    Text("Usually responds within 24 hours")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }

            Spacer()

            Button(action: { dismiss() }) {
                Text("Done")
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
    }
}
