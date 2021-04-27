//
//  CollectionView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI

struct CollectionView: View {
    
    var collectionName: String
    
    var body: some View {
        VStack {
            List(0..<4) { index in
                NavigationLink(
                    destination: PlaceView(placeName: "Place \(index + 1)"),
                    label: {
                        Text("Place \(index + 1)")
                            .font(.title2)
                    })
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddPlaceView(), label: {
//                        Image(systemName: "plus.circle")
//                            .font(.largeTitle)
                        Text("Add Place")
                    })
                }

            }
            Text("Shows all places in a collection")

        }
        .navigationTitle(collectionName)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collectionName: "Test Name").environmentObject(UserViewModel())
    }
}
