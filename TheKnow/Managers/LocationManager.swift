//
//  LocationManager.swift
//  TheKnow
//
//  Created by Josh Haber on 4/25/21.
//
import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    lazy var geocoder = CLGeocoder()
    
    @Published var locationString = ""
    @Published var locationName = ""
    @Published var invalid: Bool = false
    
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    //https://github.com/Ongomobile/OpenMapInSwiftUI/blob/main/OpenMapInSwiftUI/LocationManager.swift
    func openMapWithAddress () {
        
        geocoder.geocodeAddressString(locationString) { placemarks, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.invalid = true
                }
                print(error.localizedDescription)
            }
            
            guard let placemark = placemarks?.first else {
                return
            }
            
            guard let lat = placemark.location?.coordinate.latitude else{return}
            
            guard let lon = placemark.location?.coordinate.longitude else{return}
            
            let coords = CLLocationCoordinate2DMake(lat, lon)
            
            let place = MKPlacemark(coordinate: coords)
            
            let mapItem = MKMapItem(placemark: place)
            mapItem.name = self.locationName
            mapItem.openInMaps(launchOptions: nil)
        }
        
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print(status)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.location = location
    }
}
