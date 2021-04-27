//
//  PlaceView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI

struct PlaceView: View {
    
    var placeName: String
    
    var body: some View {
        VStack{
            Text("Shows a single place's info")
        }
        .navigationTitle(placeName)
        
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(placeName: "Test Place")
    }
}
