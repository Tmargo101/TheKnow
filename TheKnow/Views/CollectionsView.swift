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
            VStack {
                Text("Collections View")
                Button(action: {
                    user.loggedIn.toggle()
                }, label: {
                    Text("Log Out")
                })
            }
            .navigationTitle("TheKnow")
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
