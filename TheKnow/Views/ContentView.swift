//
//  ContentView.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loggedIn = false
    
    var body: some View {
        VStack {
            if (!loggedIn) {
                LoggedOutView()
            } else {
                CollectionsView()
            }
            Button(action: {
                self.loggedIn.toggle()
            }, label: {
                Text("Toggle Logged In Status")
            })

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
