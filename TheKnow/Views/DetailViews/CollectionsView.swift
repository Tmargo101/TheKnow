//
//  CollectionsView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct CollectionsView: View {
    
    @EnvironmentObject var user: UserViewModel
    
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
                    NavigationLink(destination: AddCollectionView(), label: {
                        Text("Add Collection")
                    })
                } // ToolbarItem
            } //Toolbar
            .navigationTitle(Text(Strings.MY_COLLECTIONS))
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
            .environmentObject(UserViewModel())
    }
}
