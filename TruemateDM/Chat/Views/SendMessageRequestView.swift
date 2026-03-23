import SwiftUI

struct SendMessageRequestView: View {
    @Binding var isPresented: Bool

    let contactName: String

    @State private var showMatchRequestBanner: Bool = true
    @State private var messageText: String = ""
    @State private var isMessagingLocked: Bool = true

    let messages = ChatMessage.sample

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Button(action: { isPresented = false }) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 38, height: 38)
                            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }

                Spacer()

                Text(contactName)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 38, height: 38)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
                            )
                        Image(systemName: "phone.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }

                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 38, height: 38)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
                            )
                        Image(systemName: "video.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))

            ZStack {
                Color(.systemGray6)

                ScrollView {
                    VStack(spacing: 16) {
                        if showMatchRequestBanner {
                            MatchRequestBanner {
                                showMatchRequestBanner = false
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        }

                        Text("13:58")
                            .font(.system(size: 12))
                            .foregroundColor(Color(.systemGray))
                            .padding(.top, showMatchRequestBanner ? 8 : 24)

                        ForEach(messages) { message in
                            HStack {
                                if message.isSent { Spacer() }
                                Text(message.text)
                                    .font(.system(size: 16))
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
                                if !message.isSent { Spacer() }
                            }
                            .padding(.horizontal, 16)
                        }

                        Spacer(minLength: 20)
                    }
                }
            }

            if isMessagingLocked {
                HStack {
                    Text("Messaging locked")
                        .font(.system(size: 15))
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                    Image(systemName: "lock.fill")
                        .font(.system(size: 15))
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color(.systemGray5))
                .cornerRadius(14)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
            }

            HStack(spacing: 10) {
                TextField("Send a message...", text: $messageText)
                    .font(.system(size: 15))
                    .foregroundColor(Color(.systemGray))
                    .disabled(isMessagingLocked)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(24)

                Button(action: { sendMessage() }) {
                    ZStack {
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 40, height: 40)
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                }
                .disabled(isMessagingLocked)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 28)
            .padding(.top, 4)
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }

    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        messageText = ""
    }
}

struct MatchRequestBanner: View {
    let onOkay: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.15))
                    .frame(width: 52, height: 52)
                Image(systemName: "checkmark")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.blue)
            }

            Text("Match Request Sent")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)

            VStack(spacing: 10) {
                Text("We've let them know that you're interested. To keep conversations meaningful and safe, messaging will unlock once they accept your request.")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)

                Text("You'll receive a notification when they respond.")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }

            Button(action: onOkay) {
                Text("Okay")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .cornerRadius(30)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    SendMessageRequestView(isPresented: .constant(true), contactName: "Abhishek Gupta")
}
