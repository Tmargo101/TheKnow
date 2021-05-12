//
//  ContentView.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @AppStorage("token") var UserDefaultsToken = ""
    @AppStorage("loggedIn") var UserDefaultsLoggedIn = false
    @AppStorage("email") var UserDefaultsEmail = ""
    @AppStorage("id") var UserDefaultsId = ""
    
//    init() {
//    }
    
    var body: some View {
        ZStack {
            if (user.loggedIn) {
                LoggedInView()
                    .transition(.move(edge: .trailing))
            } else {
                LoggedOutView()
                    .transition(.move(edge: .leading))
            }
        }.onAppear {
            if (!user.dev) {
                user.loggedIn = UserDefaultsLoggedIn
                user.token = UserDefaultsToken
                user.id = UserDefaultsId
                user.email = UserDefaultsEmail
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserViewModel())
    }
}
