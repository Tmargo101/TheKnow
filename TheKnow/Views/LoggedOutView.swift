//
//  LoggedOutView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct LoggedOutView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    // State variables
    @State var presentLoginSheet: Bool = false
    @State var presentSignupSheet: Bool = false
    
    var body: some View {
        VStack {
            Text(Strings.LOGGED_OUT_WELCOME)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.all)
            Spacer()
            LoggedOutViewButtons(presentLoginSheet: $presentLoginSheet, presentSignupSheet: $presentSignupSheet)
        }
        .environmentObject(user)
    }
}

struct LoggedOutView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedOutView()
    }
}

struct LoggedOutViewButtons: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @Binding var presentLoginSheet: Bool
    @Binding var presentSignupSheet: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.presentLoginSheet.toggle()
            }, label: {
                Text(Strings.LOG_IN)
            })
            .sheet(isPresented: $presentLoginSheet) {
                LoginView()
            }
            Spacer()
            Button(action: {
                self.presentSignupSheet.toggle()
            }, label: {
                Text(Strings.SIGN_UP)
            })
            .sheet(isPresented: $presentSignupSheet) {
                SignupView()
            }
            Spacer()
        }
        .padding(.bottom, 50)
        .environmentObject(user)
    }
}
