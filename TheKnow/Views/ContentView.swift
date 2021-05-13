//
//  ContentView.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @AppStorage("token") var UserDefaultsToken = ""
    @AppStorage("loggedIn") var UserDefaultsLoggedIn = false
    @AppStorage("email") var UserDefaultsEmail = ""
    @AppStorage("id") var UserDefaultsId = ""
    @AppStorage("firstName") var UserDefaultsFirstName = ""
    @AppStorage("lastName") var UserDefaultsLastName = ""
        
    var body: some View {
        ZStack {
            if (user.loggedIn) {
                LoggedInView()
                    .transition(.move(edge: .trailing))
            } else {
                LoggedOutView()
                    .transition(.move(edge: .leading))
            }
        }.onAppear {
            
            if (UserDefaultsToken == "" || UserDefaultsToken.count == 0) {
                user.setLoggedIn(status: false)
            } else {
                user.loggedIn = UserDefaultsLoggedIn
            }

            user.token = UserDefaultsToken
            user.id = UserDefaultsId
            user.email = UserDefaultsEmail
            user.firstname = UserDefaultsFirstName
            user.lastname = UserDefaultsLastName
           
        }
    }
    
}
//https://www.dabblingbadger.com/blog/2020/11/5/dismissing-the-keyboard-in-swiftui
extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        tapGesture.name = "MyTapGesture"
        window.addGestureRecognizer(tapGesture)
    }
 }
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false // set to `false` if you don't want to detect tap during other gestures
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini)"))
            .previewDisplayName("iPhone 12 Mini")
            .environmentObject(UserViewModel())

        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE 4.7 Inch")
            .environmentObject(UserViewModel())
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            .previewDisplayName("iPhone 12 Pro 6.1 Inch")
            .environmentObject(UserViewModel())
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad (8th generation)"))
            .previewDisplayName("iPad Base")
            .environmentObject(UserViewModel())

        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
            .previewDisplayName("iPad 11 Inch")
            .environmentObject(UserViewModel())
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
            .previewDisplayName("iPad 12.9 Inch")
            .environmentObject(UserViewModel())
    }
}
