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
    @AppStorage("username") var UserDefaultsUsername = ""
    @AppStorage("id") var UserDefaultsId = ""
    
//    init() {
//    }
    
    var body: some View {
        ZStack {
            if (user.loggedIn) {
                LoggedInView()
            } else {
                LoggedOutView()
                    .transition(
                        .asymmetric(
                            insertion: .offset(y: -1000),
                            removal: .offset(y: 1000)
                        )
                    )
            }
        }.onAppear {
            user.loggedIn = UserDefaultsLoggedIn
            user.token = UserDefaultsToken
            user.id = UserDefaultsId
            user.username = UserDefaultsUsername
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserViewModel())
    }
}
