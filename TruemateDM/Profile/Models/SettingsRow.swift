import SwiftUI

struct SettingsRow: Identifiable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let label: String
    let showChevron: Bool
    let action: () -> Void
}

