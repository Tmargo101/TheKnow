//
//  Place.swift
//  TheKnow
//
//  Created by Josh Haber on 4/25/21.
//
import Foundation
import MapKit

struct PlaceSearchResultModel: Identifiable {
    let item: MKMapItem
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        self.item.name ?? ""
    }
    
    var address: String {
        "\(self.item.placemark.subThoroughfare ?? "") \(self.item.placemark.thoroughfare ?? ""), \(self.item.placemark.subAdministrativeArea ?? "") \(self.item.placemark.administrativeArea ?? "")"
    }
    
    var phoneNumber: String? {
        self.item.phoneNumber ?? ""
    }
    
    var url: URL? {
        self.item.url ?? URL(string: "")
    }
    
    var title: String {
        self.item.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.item.placemark.coordinate
    }
}
