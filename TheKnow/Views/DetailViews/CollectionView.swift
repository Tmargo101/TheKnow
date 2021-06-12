//
//  CollectionView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var user: UserViewModel
    @StateObject var collectionViewModel = CollectionViewModel()
    var collectionId: String
    var collectionName: String
    @State private var showAddNewPlace: Bool = false
    
    @State var presentNewPlaceSheet: Bool = false
    
    var body: some View {
        VStack {
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
                .refreshable {
                    collectionViewModel.getCollection(token: user.token, collectionId: collectionId) { success in
                        collectionViewModel.getPlacesInCollection(token: user.token, collectionId: collectionId) { success in
                            withAnimation { collectionViewModel.loadingCollection = false }
                        }
                    }
                }
                .transition(.opacity)

            } else {
                if (collectionViewModel.loadingCollection) {
                    VStack {
                        ProgressView()
                        Text("Loading Places...")
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
            withAnimation { collectionViewModel.loadingCollection = true }

            collectionViewModel.getCollection(token: user.token, collectionId: collectionId) { success in
                collectionViewModel.getPlacesInCollection(token: user.token, collectionId: collectionId) { success in
                    withAnimation { collectionViewModel.loadingCollection = false }
                }
            }
            
        }
        .onChange(of: showAddNewPlace, perform: { _ in
            withAnimation { collectionViewModel.loadingCollection = true }
            collectionViewModel.getPlacesInCollection(token: user.token, collectionId: collectionId) { success in
                withAnimation { collectionViewModel.loadingCollection = false }
            }
        })
    }
    
    func deletePlace(at offsets: IndexSet) {
        collectionViewModel.deletePlace(token: user.token, index: offsets.first!) { _ in
            // Reload places in the collection
            collectionViewModel.getPlacesInCollection(token: user.token, collectionId: collectionId) { success in
                
            }
        }
    }
}
//
//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionView(collectionId: Binding<"String", collectionName: "Test Name").environmentObject(UserViewModel())
//    }
//}
