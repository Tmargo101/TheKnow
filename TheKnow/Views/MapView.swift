//
//  MapView.swift
//  TheKnow
//
//  Created by Josh Haber on 4/25/21.
//

import Foundation
import MapKit
import SwiftUI

class Coordinator: NSObject, MKMapViewDelegate {
    
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
    
}

struct MapView: UIViewRepresentable {
    let placeModels: [PlaceSearchResultModel]
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //
        updateAnnotations(from: uiView)
        
    }
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.placeModels.map(PlaceAnnotation.init)
        mapView.addAnnotations(annotations)
    }
}
