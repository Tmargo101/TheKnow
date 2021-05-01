
//
//  PlaceSearch.swift
//  TheKnow
//
//  Created by Josh Haber on 4/25/21.
//
import SwiftUI
import MapKit

class SearchMe: ObservableObject {
    @Published var placeSearchResults: [PlaceSearchResultModel] = []
    @ObservedObject var locationManager = LocationManager()
    
    func search(search: String) {
        print("received \(search)")
        var psr: [PlaceSearchResultModel] = []
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        if let loc = locationManager.location {
            let region = MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            request.region = region
        }
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                
                psr = mapItems.map {
                    PlaceSearchResultModel(item: $0)
                }
                self.placeSearchResults = psr
            }

        }

    }
}

struct PlaceSearch: View {
    @State private var search: String = ""
    @ObservedObject var locationManager = LocationManager()
    @State private var placeSearchResults: [PlaceSearchResultModel] = [PlaceSearchResultModel]()
    @State private var tapped: Bool = false
    
    func getNearbyLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
//        request.region
//        https://developer.apple.com/documentation/mapkit/mklocalsearch/request
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                
                self.placeSearchResults = mapItems.map {
                    PlaceSearchResultModel(item: $0)
                }
                
            }
            
        }
    }
    
    func getSearchResults(str: String) -> [PlaceSearchResultModel] {
        self.search = str
        return placeSearchResults
    }
    
    private func calculateOffset() -> CGFloat {
        if self.placeSearchResults.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.height / 4
        }
        else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            
            MapView(placeModels: placeSearchResults)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            TextField("Search", text: $search, onEditingChanged: { _ in }) {
                self.getNearbyLandmarks()
                //commit
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .offset(y: 44)
            
            PlaceListView(places: self.placeSearchResults) {
                //on tap
                self.tapped.toggle()
            }.offset(y: calculateOffset())
            .animation(.spring())
        }
    }
}

struct PlaceSearch_Previews: PreviewProvider {
    static var previews: some View {
        PlaceSearch()
    }
}
