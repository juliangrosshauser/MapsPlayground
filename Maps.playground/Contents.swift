import CoreLocation

/*:
# Get current location
Based on Apple's ["Getting the User’s Location"](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/CoreLocation/CoreLocation.html#//apple_ref/doc/uid/TP40009497-CH2-SW1)
*/

class LocationManager: NSObject, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500

        locationManager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        let location = locations.last as! CLLocation
        let eventDate = location.timestamp
        let timeSinceEvent = eventDate.timeIntervalSinceNow

        if abs(timeSinceEvent) < 15 {
            print("Current location: latitude = \(location.coordinate.latitude), longitude = \(location.coordinate.longitude)")
            
            currentLocation = location
        }
    }
}

let locationManager = LocationManager()
