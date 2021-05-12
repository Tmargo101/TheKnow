//
//  RefreshButtonView.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/12/21.
//

import SwiftUI

struct RefreshButtonView: View {
    @Binding var loading: Bool
    var image = ""
        
    var body: some View {
        if (!loading) {
            Image(systemName: "arrow.clockwise")
                .transition(.opacity)
        } else {
            ProgressView()
                .padding(.trailing, 10)
        }
    }
}

struct RefreshButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButtonView(loading: .constant(true))
    }
}
