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
            .sheet(isPresented: $showAddNewPlace, content: {
                AddPlaceView(location: "", isShow: $showAddNewPlace)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showAddNewPlace = true
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                    }
                }

            }
            
//            if showAddNewPlace {
//                BlankView(bgColor: .black)
//                    .opacity(0.5)
//                    .onTapGesture {
//                        self.showAddNewPlace = false
//                    }
//                AddPlaceView(location: "", isShow: $showAddNewPlace)
//                    .transition(.move(edge: .bottom))
//                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
//            }
            

        }
        .navigationTitle(collectionName)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collectionName: "Test Name").environmentObject(UserViewModel())
    }
}
