//
//  CollectionView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var user: UserViewModel
    @ObservedObject var collectionViewModel = CollectionViewModel()
    var collectionId: String
    var collectionName: String
    @State private var showAddNewPlace: Bool = false
    
    @State var presentNewPlaceSheet: Bool = false
    
    var body: some View {
        VStack {
            if (!collectionViewModel.loadingPlaces) {
                if (collectionViewModel.places.count > 0) {
                    List(collectionViewModel.places) { place in
                        NavigationLink(
                            destination: PlaceView(place: place),
                            label: {
                                Text(place.name)
                                    .font(.title2)
                            })
                            .padding()
                    }
                } else {
                    Text("No Places")
                        .font(.system(.title, design: .rounded))
                }
            } else {
                VStack {
                    ProgressView()
                    Text("Loading Places...")
                }
                
            }
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
        .navigationTitle(collectionName)
        .onAppear() {
            print(collectionId)
            collectionViewModel.getPlacesInCollection(token: user.token, collectionId: collectionId)
        }
    }
}
//
//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionView(collectionId: Binding<"String", collectionName: "Test Name").environmentObject(UserViewModel())
//    }
//}
