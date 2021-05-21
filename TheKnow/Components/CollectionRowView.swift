//
//  CollectionRowView.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/12/21.
//

import SwiftUI

struct CollectionRowView: View {
    
    var collection: Collection
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(collection.name)")
                .font(.system(size: 28, design: .rounded))
                .bold()
                .padding(.bottom, 3)
            Text("\(collection.places!.count) \(collection.places!.count == 1 ? "Place" : "Places")")
                .font(.headline)
        }

    }
}

struct CollectionRowView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRowView(collection: Collection())
    }
}
