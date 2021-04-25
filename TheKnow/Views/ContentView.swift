//
//  ContentView.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var user = UserViewModel()    
    
    var body: some View {
        VStack {
            if (!user.loggedIn) {
                LoggedOutView()
            } else {
                CollectionsView()
            }
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
