//
//  PlaceAnnotation.swift
//  TheKnow
//
//  Created by Josh Haber on 4/25/21.
//
import Foundation
import MapKit

final class PlaceAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(place: PlaceSearchResultModel) {
        self.title = place.name
        self.coordinate = place.coordinate
    }
}
