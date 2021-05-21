//
//  RoundButtonView.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/12/21.
//

import SwiftUI

struct RoundButtonView: View {
    
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

struct RoundButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RoundButtonView(sfSymbol: "phone.circle.fill", buttonText: "Call", color: .green, size: 32.0, link: "", name: "", phoneNumber: "", website: "")
    }
}
