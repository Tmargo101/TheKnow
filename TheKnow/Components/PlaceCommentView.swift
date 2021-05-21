//
//  PlaceCommentView.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/12/21.
//

import SwiftUI

struct PlaceCommentView: View {
    
    var comment: PlaceComment
    
    init(_comment: PlaceComment) {
        comment = _comment
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(comment.name!.trimmingCharacters(in: .whitespacesAndNewlines))")
                .font(.system(size: 24, design: .rounded))
                .bold()
                .padding(.bottom, 5)
            
            Text("\(comment.text!.trimmingCharacters(in: .whitespacesAndNewlines))")
                .font(.body)
        }
        .padding(15)
    }
}

struct PlaceCommentView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCommentView(_comment: PlaceComment())
    }
}
