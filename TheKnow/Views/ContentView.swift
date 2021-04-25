//
//  ContentView.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    let api = API.shared
    
    @State var placeLists: [PlaceList] = []
    
    init() {
        
        api.getLists { (returnedLists) in
            guard let safeLists = returnedLists else {
                // handle error
                return
            }
            self.placeLists = safeLists
        }
        
    }
    
    var body: some View {
        NavigationView {
            List(0..<placeLists.count) { placeList in
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Navigate")
                    })
            }
        }
        .navigationTitle("The Know")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
