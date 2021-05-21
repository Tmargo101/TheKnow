//
//  PlaceActionsRow.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/12/21.
//

import SwiftUI

struct PlaceActionsRowView: View {
    
    var place: Place
    
    var body: some View {
        HStack { // Quick Actions
            if (place.placeData?.phoneNumber != nil) {
                RoundButtonView(sfSymbol: "phone.circle.fill", buttonText: "Call", color: .green, size: 32.0, link: "", name: "", phoneNumber: place.placeData!.phoneNumber!, website: "")
                    .padding(.horizontal, 24.0)
            }
            if (place.placeData?.address != nil) {
                RoundButtonView(sfSymbol: "arrow.triangle.turn.up.right.circle.fill", buttonText: "Directions", color: .blue, size: 32.0, link: (place.placeData?.address)!, name: place.name, phoneNumber: "", website: "")
                    .padding(.horizontal, 24.0)
            }
            if (place.placeData?.link != nil) {
                RoundButtonView(sfSymbol: "link.circle.fill", buttonText: "Website", color: .blue, size: 32.0, link: "", name: "", phoneNumber: "", website: place.placeData!.link!)
                    .padding(.horizontal, 20.0)
            }
        }
    }
}

struct PlaceActionsRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaceActionsRowView(place: Place())
    }
}
