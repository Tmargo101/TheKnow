//
//  Place.swift
//  TheKnow
//
//  Created by Josh Haber on 4/25/21.
//
import Foundation
import MapKit

struct PlaceSearchResultModel {
    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
