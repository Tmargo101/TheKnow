//
//  ContentView.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        ZStack {
            if (user.loggedIn) {
                CollectionsView()
            } else {
                LoggedOutView()
            }
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserViewModel())
    }
}
