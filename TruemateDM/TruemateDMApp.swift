import SwiftUI

@main
struct TruemateApp: App {

    var body: some Scene {
        WindowGroup {
            AuthEntryView()
        }
    }
}

extension Notification.Name {
    static let switchToChatsTab = Notification.Name("switchToChatsTab")
    static let didSendMessageRequest = Notification.Name("didSendMessageRequest")
}
