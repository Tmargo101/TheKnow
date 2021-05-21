//
//  PlaceRowView.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/12/21.
//

import SwiftUI

struct PlaceRowView: View {
    
    var place: Place
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(place.name)")
                .font(.system(size: 24, design: .rounded))
                .bold()
                .padding(.bottom, 3)
            Text("Recommended by \(place.recommendedBy?.name ?? "")")
                .font(.subheadline)
        }

    }
}

struct PlaceRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRowView(place: Place())
    }
}
