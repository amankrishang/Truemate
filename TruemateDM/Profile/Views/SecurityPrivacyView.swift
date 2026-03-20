import SwiftUI

struct SecurityPrivacyView: View {
    @Environment(\.dismiss) var dismiss
    @State private var notificationsEnabled: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 36, height: 36)
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }

                Spacer()

                Text("Security & Privacy")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Circle()
                    .fill(Color.clear)
                    .frame(width: 36, height: 36)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            ScrollView {
                VStack(spacing: 12) {
                    Button(action: {}) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Passwords & Passkey")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.primary)
                                Text("Change your account password")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(.systemGray))
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Notification Settings")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.primary)
                            Text("Receive account & security related alerts")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.systemGray))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                        Toggle("", isOn: $notificationsEnabled)
                            .labelsHidden()
                            .tint(.green)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)

                    Spacer()
                }
            }
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }
}

#Preview {
    SecurityPrivacyView()
}
