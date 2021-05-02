//
//  CollectionsView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI
import Alamofire

struct CollectionsView: View {
        
    @EnvironmentObject var user: UserViewModel
    @ObservedObject var collectionsViewModel = CollectionsViewModel()
    
    @State private var showAddNewCollection: Bool = false
    
    @State var presentNewCollectionSheet: Bool = false
    
//    @State var collections = [Collection]()
    
    var body: some View {
        
        ZStack {
            VStack {
                if (!collectionsViewModel.loadingCollections) {
                    if (collectionsViewModel.collections.count > 0) {
                        List(collectionsViewModel.collections) { collection in
                            NavigationLink(
                                destination: CollectionView(collectionId: collection.id, collectionName: "\(collection.name)"),
                                label: {
                                    Text("\(collection.name)")
                                        .font(.title2)
                                })
                                .padding()
                        }
                        .listStyle(SidebarListStyle())
                    } else {
                        Text("No Collections")
                    }
                } else {
                    VStack {
                        ProgressView()
                        Text("Loading Collections...")
                    }
                }
            }
            .transition(.opacity)
            .onAppear {
                collectionsViewModel.getAllCollections(token: user.token, id: user.id)
            }
            .sheet(isPresented: $presentNewCollectionSheet) {
                AddCollectionView(name: "", isShow: $showAddNewCollection)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: AccountView(), label: {
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
            .navigationTitle(Text(Strings.MY_COLLECTIONS))


//            .rotation3DEffect(Angle(degrees: showAddNewCollection ? 5 : 0), axis: (x: 1, y: 0, z: 0))
//            .offset(y: showAddNewCollection ? -50 : 0)
//            .animation(.easeOut)
        
        
            if showAddNewCollection {
                BlankView(bgColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showAddNewCollection = false
                    }
                
                AddCollectionView(name: "", isShow: $showAddNewCollection)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            }
        }
    } // Body
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
            .environmentObject(UserViewModel())
    }
}

struct BlankView : View {
    
    var bgColor: Color
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}
