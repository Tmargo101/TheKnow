//
//  PlaceView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI

struct PlaceView: View {
    
//    @Binding var placeName: String
//    @Binding var reccomendedBy: String
//    @Binding var note: String

    var placeName: String
    var reccomendedBy: String
    var note: String

    
    var body: some View {
        VStack {
            placeNameBarView(reccomendedBy: reccomendedBy, name: placeName) // Title & Subtitle Row

            quickActionsToolbarView() // Quick Actions Row
            placeNotesView(note: note)
        }
//        .navigationTitle(placeName)
        
    }
}

struct placeNameBarView: View {
    
//    @Binding var reccomendedBy: String
    @State var reccomendedBy: String
    @State var name: String

    var body: some View {
        HStack { // Title & Reccomended By
            VStack {
                HStack {
                    Text(name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                        .lineLimit(1)
                    Spacer()
                }
                HStack {
                    Text("Reccomended by \(reccomendedBy)")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .padding(.leading)
                        .lineLimit(1)
                    Spacer()
                }
            }
            .padding(.bottom, 18.0)
            Spacer()
            
        }
    }
}


struct roundButtonView: View {
    
    var sfSymbol: String
    var buttonText: String
    var color: Color
    var size: CGFloat
    
    var body: some View {
        Button(action: {
            
        }, label: {
            VStack {
                Image(systemName: sfSymbol)
                    .font(.system(size: size))
                    .foregroundColor(color)
                Text(buttonText)
                    .foregroundColor(color)
            }
        })

    }
}


struct quickActionsToolbarView: View {
    var body: some View {
        HStack { // Quick Actions
            roundButtonView(sfSymbol: "phone.circle.fill", buttonText: "Call", color: .green, size: 32.0)
                .padding(.horizontal, 24.0)
            roundButtonView(sfSymbol: "arrow.triangle.turn.up.right.circle.fill", buttonText: "Directions", color: .blue, size: 32.0)
                .padding(.horizontal, 24.0)
            roundButtonView(sfSymbol: "link.circle.fill", buttonText: "Website", color: .blue, size: 32.0)
                .padding(.horizontal, 20.0)
        }
    }
}


struct placeNotesView: View {
    
//    @Binding var note: String
    @State var note: String
    
    var body: some View {
        GroupBox(label:
                    Text("Notes")
                    .font(.title3)
                    .fontWeight(.semibold)) {
            TextEditor(text: $note)
                .foregroundColor(.primary)
                .lineSpacing(10.0)
                .padding(7.5)
                .font(.system(size: 18))
                .background(Color(UIColor.systemBackground))
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 100, idealHeight: 200, maxHeight: 300, alignment: .center)
            
        }
        .padding()
    }
}


//struct PlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceView()
//    }
//}
