import CoreLocation

final class LocationPermissionManager {
    private let manager = CLLocationManager()

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
}
