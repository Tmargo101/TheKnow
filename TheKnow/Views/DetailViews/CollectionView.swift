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
            if (collectionViewModel.loadingPlaces && collectionViewModel.places.count == 0) {
                VStack {
                    ProgressView()
                    Text("Loading Places...")
                }
            } else {
                if (collectionViewModel.places.count > 0) {
                    List {
                        ForEach(collectionViewModel.places) { place in
                            NavigationLink(
                                destination: PlaceView(_place: place),
                                label: {
                                    PlaceRowView(place: place)
                                })
                                .padding()
                        }
                        .onDelete(perform: deletePlace)
                    }
                    .transition(.opacity)
                } else {
                    Text("No Places")
                        .font(.system(.title, design: .rounded))
                        .transition(.opacity)
                }
            }
        }
        .sheet(isPresented: $showAddNewPlace, content: {
            AddPlaceView(
                token: user.token ?? "",
                userId: user.id ?? "",
                collectionId: collectionId,
                fullName: "\(user.firstname ?? "") \(user.lastname ?? "")",
                isShow: $showAddNewPlace
            )
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    collectionViewModel.getPlacesInCollection(token: user.token, collectionId: collectionId)
                }) {
                    RefreshButtonView(loading: $collectionViewModel.loadingPlaces, image: "arrow.clockwise")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showAddNewPlace.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                })
            }

        }
        .navigationTitle(collectionName)
        .onAppear() {
            print(collectionId)
            collectionViewModel.getPlacesInCollection(token: user.token, collectionId: collectionId)
        }
        .onChange(of: showAddNewPlace, perform: { value in
            collectionViewModel.getPlacesInCollection(token: user.token, collectionId: collectionId)
        })
    }
    
    func deletePlace(at offsets: IndexSet) {
        collectionViewModel.deletePlace(token: user.token, index: offsets.first!) { _ in 
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
