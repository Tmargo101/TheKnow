//
//  PlaceView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    
    @EnvironmentObject var user: UserViewModel
    @ObservedObject var placeViewModel = PlaceViewModel()
    @State var addCommentText = ""
    
    var comments: [PlaceComment]?
    
    init(_place: Place) {
        placeViewModel.place = _place
        
        if let comments = placeViewModel.place.comments {
            self.comments = comments
        }
    }
    
    var body: some View {
        ZStack {
        }
        VStack {
            
            // Title & Subtitle Row
            placeNameBarView(
                recommendedBy: placeViewModel.place.recommendedBy?.name ?? "",
                name: placeViewModel.place.name
            )
            
            // Actions Row
            PlaceActionsRowView(place: placeViewModel.place)
                .padding(.bottom, 20)
            
            if let _ = comments {
                List {
                    ForEach (comments!, id: \.self) { comment in
                        //MARK: Center Align
                        PlaceCommentView(_comment: comment)
                    }
                }
            }
            
        }
        .navigationTitle(placeViewModel.place.name)

        .onAppear() {
            //            placeViewModel.getPlace(token: user.token, placeId: placeViewModel.place.id)
        }
        
//        GroupBox {
//            Text("Add A Comment")
//                .font(.title2)
//                .fontWeight(.semibold)
//            TextEditor(text: $addCommentText)
//                .frame(minHeight: 50, idealHeight: 100)
//                .foregroundColor(.black)
//                .opacity(0.5)
//                .keyboardType(.webSearch)
//                .edgesIgnoringSafeArea(.bottom)
//
//        }
//        .frame(minHeight: 150, maxHeight: 200)
//        .background(Color(.systemGray5))
//        .cornerRadius(10.0)
//        .navigationTitle(placeViewModel.place.name)
        
    }
}



struct placeNameBarView: View {
    
    var recommendedBy: String
    var name: String
    
    var body: some View {
        HStack { // Title & Reccomended By
            VStack {
//                HStack {
//                    Text(name)
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.leading)
//                        .lineLimit(1)
//                    Spacer()
//                }
                if (recommendedBy != "") {
                    HStack {
                        Text("Recommended by \(recommendedBy)")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .padding(.leading, 25)
                            .lineLimit(1)
                        Spacer()
                    }
                }
            }
            .padding(.bottom, 18.0)
            Spacer()
            
        }
    }
}


struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(_place: Place())
            .environmentObject(UserViewModel())
    }
}
