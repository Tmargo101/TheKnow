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
            
            // Quick Actions Row
            quickActionsToolbarView(place: placeViewModel.place)
                .padding(.bottom, 20)
            if let _ = comments {
                List {
                    ForEach (comments!, id: \.self) { c in
                        //MARK: Center Align
                        VStack(alignment: .leading) {
                            Text("\(c.name!.trimmingCharacters(in: .whitespacesAndNewlines))")
                                .font(.system(size: 24, design: .rounded))
                                .bold()
                                .padding(.bottom, 5)
                            
                            Text("\(c.text!.trimmingCharacters(in: .whitespacesAndNewlines))")
                                .font(.body)
                        }
                        .padding(15)
                    }
                }
            }
            
        }
        .onAppear() {
            //            placeViewModel.getPlace(token: user.token, placeId: placeViewModel.place.id)
        }
        
        GroupBox {
            Text("Add A Comment")
                .font(.title2)
                .fontWeight(.semibold)
            TextEditor(text: $addCommentText)
                .frame(minHeight: 50, idealHeight: 100)
                .foregroundColor(.black)
                .opacity(0.5)
                .keyboardType(.webSearch)
                .edgesIgnoringSafeArea(.bottom)

        }
        .frame(minHeight: 150, maxHeight: 200)
        .background(Color(.systemGray5))
        .cornerRadius(10.0)
        .navigationTitle(placeViewModel.place.name)
        
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


struct roundButtonView: View {
    
    @Environment(\.openURL) var openURL
    @ObservedObject var locationManager = LocationManager()
    
    var sfSymbol: String
    var buttonText: String
    var color: Color
    var size: CGFloat
    var link: String
    var name: String
    var phoneNumber: String
    var website: String
    
    var body: some View {
        Button(action: {
            if link != "" {
                locationManager.locationString = link
                locationManager.locationName = name
                locationManager.openMapWithAddress()
            }
            if phoneNumber != "" {
                let tel = "tel://"
                let formattedPhoneNumber = phoneNumber.filter("0123456789.".contains)
                let formattedString = tel + formattedPhoneNumber
                print(formattedString)
                guard let url = URL(string: formattedString) else { return }
                UIApplication.shared.open(url)
            }
            if website != "" {
                guard let site = URL(string: website) else { return }
                UIApplication.shared.open(site)
            }
            
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
    
    var place: Place
    
    var body: some View {
        HStack { // Quick Actions
            if (place.placeData?.phoneNumber != nil) {
                roundButtonView(sfSymbol: "phone.circle.fill", buttonText: "Call", color: .green, size: 32.0, link: "", name: "", phoneNumber: place.placeData!.phoneNumber!, website: "")
                    .padding(.horizontal, 24.0)
            }
            if (place.placeData?.address != nil) {
                roundButtonView(sfSymbol: "arrow.triangle.turn.up.right.circle.fill", buttonText: "Directions", color: .blue, size: 32.0, link: (place.placeData?.address)!, name: place.name, phoneNumber: "", website: "")
                    .padding(.horizontal, 24.0)
            }
            if (place.placeData?.link != nil) {
                roundButtonView(sfSymbol: "link.circle.fill", buttonText: "Website", color: .blue, size: 32.0, link: "", name: "", phoneNumber: "", website: place.placeData!.link!)
                    .padding(.horizontal, 20.0)
            }
        }
    }
}

//struct PlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceView()
//    }
//}
