//
//  PlaceListView.swift
//  TheKnow
//
//  Created by Josh Haber on 4/25/21.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    let places: [PlaceSearchResultModel]
    
    var onTap: () ->()
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
            .background(Color.blue)
            .gesture(TapGesture().onEnded(self.onTap))
            
            List {
                ForEach(self.places, id: \.id) { place in
                    VStack (alignment: .leading) {
                        Text(place.name)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text(place.title)
                    }
                }
            }.animation(nil)
        }.cornerRadius(15)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(places: [PlaceSearchResultModel(placemark: MKPlacemark())], onTap: {})
    }
}
