//
//  CollectionsView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI
import SwiftUIRefresh

struct CollectionsView: View {
        
    @EnvironmentObject var user: UserViewModel
    @StateObject var collectionsViewModel = CollectionsViewModel()
    
    @State private var editMode: Bool = false
    
    @State private var showAddNewCollection: Bool = false
    
    @State var presentNewCollectionSheet: Bool = false
    
    @State var showAccountSheet: Bool = false
        
    var body: some View {
        
        ZStack {
            VStack {
                if (collectionsViewModel.collections.count == 0) {
                    if (collectionsViewModel.loadingCollections) {
                        VStack {
                            ProgressView()
                            Text("Loading Collections...")
                        }
                        .transition(.opacity)
                    } else {
                        Text("No Collections")
                    }
                } else {
                    List {
                        ForEach(collectionsViewModel.collections) { collection in
                            NavigationLink(
                                destination: CollectionView(collectionId: collection.id, collectionName: "\(collection.name)"),
                                label: {
                                    CollectionRowView(collection: collection)
                                })
                                .padding()
                        }
                        .onDelete(perform: deleteCollection)
                        .pullToRefresh(isShowing: $collectionsViewModel.loadingCollections) {
                            collectionsViewModel.loadingCollections = true
                            collectionsViewModel.getAllCollections(token: user.token, id: user.id) { _ in
                                collectionsViewModel.loadingCollections = false
                            }
                        }
                    }
                }
            }
            .transition(.opacity)
            .onAppear {
                withAnimation { collectionsViewModel.loadingCollections = true }
                collectionsViewModel.getAllCollections(token: user.token, id: user.id) { _ in
                    withAnimation { collectionsViewModel.loadingCollections = false }
                }
            }
            .onChange(of: showAddNewCollection, perform: { _ in
                collectionsViewModel.loadingCollections = true
                collectionsViewModel.getAllCollections(token: user.token, id: user.id) { success in
                    collectionsViewModel.loadingCollections = false
                }
            })
            .sheet(isPresented: $presentNewCollectionSheet) {
                AddCollectionView(name: "", isShow: $showAddNewCollection)
            }
            .sheet(isPresented: $showAccountSheet) {
                AccountView(showing: $showAccountSheet).environmentObject(user)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.showAccountSheet = true
                    }, label: {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showAddNewCollection = true
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                    }
                } // ToolbarItem
            } //Toolbar
            .navigationTitle(Text("\((user.firstname != "") ? "\(user.firstname ?? "")'s" :  "My") Collections"))


//            .rotation3DEffect(Angle(degrees: showAddNewCollection ? 5 : 0), axis: (x: 1, y: 0, z: 0))
//            .offset(y: showAddNewCollection ? 50 : 0)
//            .animation(.easeOut)
        
        
            if showAddNewCollection {
                BlankView(bgColor: .secondary)
                    .opacity(0.5)
                    .onTapGesture {
                        withAnimation {
                            self.showAddNewCollection = false
                        }
                    }
                
                AddCollectionView(name: "", isShow: $showAddNewCollection)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            }
        }
    } // Body
    
    func deleteCollection(at offsets: IndexSet) {
        print(offsets.first!)
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        
        CollectionsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE 4.7 Inch")
            .environmentObject(UserViewModel())
        
        CollectionsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro 6.1 Inch"))
            .previewDisplayName("iPhone 12 Pro")
            .environmentObject(UserViewModel())
        
        CollectionsView()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
            .previewDisplayName("iPad 11 Inch")
            .environmentObject(UserViewModel())

    }
}
