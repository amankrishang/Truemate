import SwiftUI
import CoreLocation

struct LocationPermissionView: View {
    @Binding var showNext: Bool
    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            ZStack {
                Circle()
                    .fill(accentColor.opacity(0.1))
                    .frame(width: 140, height: 140)
                Circle()
                    .fill(accentColor.opacity(0.15))
                    .frame(width: 100, height: 100)
                Image(systemName: "location.fill")
                    .font(.system(size: 48))
                    .foregroundColor(accentColor)
            }

            VStack(spacing: 12) {
                Text("Find Nearby")
                    .font(.system(size: 26, weight: .bold))
                Text("Allow location access to discover flats and flatmates near you.")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()

            VStack(spacing: 12) {
                Button(action: {
                    requestLocationPermission()
                    showNext = true
                }) {
                    Text("Enable Location")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(accentColor)
                        .cornerRadius(14)
                }

                Button(action: { showNext = true }) {
                    Text("Maybe Later")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 48)
        }
        .background(Color(.systemBackground))
    }

    private func requestLocationPermission() {
        CLLocationManager().requestWhenInUseAuthorization()
    }
}
