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
    
    @State private var editMode: Bool = false
    
    @State private var showAddNewCollection: Bool = false
    
    @State var presentNewCollectionSheet: Bool = false
    
    @State var showAccountSheet: Bool = false
    
//    @State var collections = [Collection]()
    
    var body: some View {
        
        ZStack {
            VStack {
                if (!collectionsViewModel.loadingCollections) {
                    if (collectionsViewModel.collections.count > 0) {
                        List {
                            ForEach(collectionsViewModel.collections) { collection in
                                NavigationLink(
                                    destination: CollectionView(collectionId: collection.id, collectionName: "\(collection.name)"),
                                    label: {
                                        CollectionRowView(collection: collection)
//                                        HStack {
//                                            Text("\(collection.name)")
//                                                .font(.title2)
//                                                .padding(.bottom, 1)
//                                            Spacer()
//                                            Text("\(collection.places!.count) Places")
//                                                .font(.headline)
//                                        }
                                    })
                                    .padding()
                            }
                            .onDelete(perform: deleteCollection)
                        }
                        .listStyle(SidebarListStyle())
                        .transition(.opacity)
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
            .onChange(of: showAddNewCollection, perform: { _ in
                collectionsViewModel.getAllCollections(token: user.token, id: user.id)
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
                    EditButton()
                        .onTapGesture {
                            editMode.toggle()
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        collectionsViewModel.getAllCollections(token: user.token, id: user.id)
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                    }
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
                BlankView(bgColor: .secondary)
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
    
    func deleteCollection(at offsets: IndexSet) {
        print(offsets.first!)
    }
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
