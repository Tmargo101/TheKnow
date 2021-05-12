//
//  TheKnowApp.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import SwiftUI

@main
struct TheKnowApp: App {
    @StateObject var user = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(user)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)

        }
    }
}
