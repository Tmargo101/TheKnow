//
//  CollectionView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI

struct CollectionView: View {
    
    var collectionName: String
    @State private var showAddNewPlace: Bool = false
    
    @State var presentNewPlaceSheet: Bool = false
    
    var body: some View {
        VStack {
            List(0..<4) { index in
                NavigationLink(
                    destination: PlaceView(placeName: "Place \(index + 1)", reccomendedBy: "Tom M", note: ""),
                    label: {
                        Text("Place \(index + 1)")
                            .font(.title2)
                    })
                    .padding()
            }
            .sheet(isPresented: $showAddNewPlace, content: {
                AddPlaceView(location: "", isShow: $showAddNewPlace)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddNewPlace.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                    })
                }

            }
        }
        .navigationTitle(collectionName)
//        .onAppear() {
//            
//        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collectionName: "Test Name").environmentObject(UserViewModel())
    }
}
