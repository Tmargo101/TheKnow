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
    
    var comments: [PlaceComment]?
    
    init(_place: Place) {
        placeViewModel.place = _place
        
        if let comments = placeViewModel.place.comments {
            self.comments = comments
        }
    }
    
    var body: some View {
        VStack {
            
            // Title & Subtitle Row
            placeNameBarView(
                recommendedBy: placeViewModel.place.recommendedBy?.name ?? "",
                name: placeViewModel.place.name
            )
            
            // Quick Actions Row
            quickActionsToolbarView(place: placeViewModel.place)
                .padding(.bottom, 20)
            //            if (placeViewModel.place.comments > 0) {
            //                List(placeViewModel.place.comments) { comment in
            //
            //                }
            //            }
            if let _ = comments {
                List {
                    ForEach (comments!, id: \.self) { c in
                        //MARK: Center Align These Fuckers
                        VStack(alignment: .leading) {
                            Text("\(c.name!.trimmingCharacters(in: .whitespacesAndNewlines))")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            
                            Text("\(c.text!.trimmingCharacters(in: .whitespacesAndNewlines))")
                                .font(.body)
                        }
                        .padding(15)
                    }
                }
            }
            
            // Comment View
            //            placeNotesView(note: placeViewModel.place.note ?? "")
            Spacer()
        }
        .onAppear() {
            //            placeViewModel.getPlace(token: user.token, placeId: placeViewModel.place.id)
        }
        //        .navigationTitle(placeName)
        
    }
}

struct placeNameBarView: View {
    
    //    @Binding var reccomendedBy: String
    @State var recommendedBy: String
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
                if (recommendedBy != "") {
                    HStack {
                        Text("Recommended by \(recommendedBy)")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .padding(.leading)
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
            //            openURL(URL(string: link)!)
            if link != "" {
                locationManager.locationString = link
                locationManager.locationName = name
                locationManager.openMapWithAddress()
            }
            if phoneNumber != "" {
                let tel = "tel://"
                let formattedString = tel + phoneNumber
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
