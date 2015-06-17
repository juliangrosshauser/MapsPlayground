import CoreLocation
import MapKit
import XCPlayground

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

/*:
# Display location in map view
Based on Apple's ["Displaying Maps"](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/MapKit/MapKit.html#//apple_ref/doc/uid/TP40009497-CH3-SW1)
*/

let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

// show New York in map view
mapView.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 40.7141667, longitude: -74.0063889), 5000, 5000)

XCPShowView("Map View", view: mapView)
