import SwiftUI
import UserNotifications

struct NotificationsPermissionView: View {
    var onAllow: (() -> Void)? = nil
    var onNotNow: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Image(systemName: "bell.badge.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
                .foregroundColor(.blue)
                .padding(.bottom, 40)

            Text("Stay updated\ninstantly")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .lineSpacing(2)
                .padding(.bottom, 20)

            Text("We'll notify you when you get a\nmatch or a new listing is posted")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            Spacer()

            Button(action: {
                requestNotificationPermission()
                onAllow?()
            }) {
                Text("Allow Notifications")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color.blue)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)

            Button(action: {
                onNotNow?()
            }) {
                Text("Not Now")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 24)

            Text("You can change this anytime in Settings")
                .font(.system(size: 13))
                .foregroundColor(Color(.systemGray))
                .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationBarHidden(true)
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Notification permission error: \(error.localizedDescription)")
                } else {
                    print("Notification permission granted: \(granted)")
                }
            }
        }
    }
}

#Preview {
    NotificationsPermissionView()
}
