//
//  CollectionsView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct CollectionsView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        NavigationView {
            List(0..<4) { index in
                NavigationLink(
                    destination: Text("Collection \(index)"),
                    label: {
                        Text("Collection \(index + 1)")
                            .font(.title2)
                    })
                    .padding()
            }
            .navigationBarItems(leading:
                HStack {
                    Button(action: {
                        user.logout()
                    }) {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                    }.foregroundColor(.blue)
                }, trailing:
                HStack {
                    Button(action: {}) {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                    }.foregroundColor(.blue)
                })
                .navigationTitle(Strings.MY_COLLECTIONS)


        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
