import SwiftUI
import CoreLocation
import Combine

struct LocationPermissionView: View {
    var onEnable: (() -> Void)? = nil
    var onNotNow: (() -> Void)? = nil

    @State private var locationManager = LocationPermissionManager()

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Image(systemName: "location.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.bottom, 40)

            Text("See who's near\nyou")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .lineSpacing(2)
                .padding(.bottom, 20)

            Text("Your location is only used to improve\nmatches and is never shared without\nyour consent.")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            Spacer()

            Button(action: {
                locationManager.requestPermission()
                onEnable?()
            }) {
                Text("Enable Location")
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
}

#Preview {
    LocationPermissionView()
}
