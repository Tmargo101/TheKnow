//
//  CollectionsView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct CollectionsView: View {
    
    @EnvironmentObject var user: UserViewModel
    @State private var showAddNewCollection: Bool = false
    
    @State var presentNewCollectionSheet: Bool = false
    
    var body: some View {

        NavigationView {
            List(0..<4) { index in
                NavigationLink(
                    destination: CollectionView(collectionName: "Collection \(index + 1)"),
                    label: {
                        Text("Collection \(index + 1)")
                            .font(.title2)
                    })
                    .isDetailLink(false)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: AccountView(), label: {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                    })
                }
                ToolbarItem(placement: .principal) {
                    Text("TheKnow")
                        .fontWeight(.bold)
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
        }
        
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
