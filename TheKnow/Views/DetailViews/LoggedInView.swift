//
//  LoggedInView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/27/21.
//

import SwiftUI

struct LoggedInView: View {
    
    @EnvironmentObject var user: UserViewModel

    var body: some View {
        NavigationView {
            CollectionsView()
            Text("This should only show on iPad, find something to put here!")
        }
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
    }
}
