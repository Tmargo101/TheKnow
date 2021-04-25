//
//  LoggedOutView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct LoggedOutView: View {
    
    @State private var presentLoginSheet: Bool = false
    @State private var presentSignupSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to The Know")
                .font(.title)
                .padding(.all)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.presentLoginSheet.toggle()
                }, label: {
                    Text(Strings.LOG_IN)
                })
                .sheet(isPresented: $presentLoginSheet, content: {
                    LoginView()
                })
                Spacer()
                Button(action: {
                    self.presentSignupSheet.toggle()
                }, label: {
                    Text(Strings.SIGN_UP)
                })
                .sheet(isPresented: $presentSignupSheet, content: {
                    SignupView()
                })
                Spacer()
            }
            .padding(.bottom, 50)
        }
    }
}

struct LoggedOutView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedOutView()
    }
}
