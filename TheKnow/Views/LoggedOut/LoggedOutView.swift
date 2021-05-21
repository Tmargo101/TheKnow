//
//  LoggedOutView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct LoggedOutView: View {
    
    @EnvironmentObject var user: UserViewModel
        
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Welcome to")
                    .font(.system(size: 32, design: .rounded))
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(.white)
                Text("TheKnow")
                    .font(.system(size: 52, design: .rounded))
                    .fontWeight(.bold)
                    .padding(.top, 2)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                Text("Keep track of your favorite places to eat, and share them with your friends!")
                    .font(.system(.headline, design: .rounded))
                    .padding()
                    .padding(.horizontal, 30)
                    .foregroundColor(.white)

                Spacer()
                LoggedOutViewButtons()
            }

        }

        
    }
}

struct LoggedOutViewButtons: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @State var showLoginSheet: Bool = false
    @State var showSignupSheet: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                showLoginSheet = true
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(minWidth: 200, maxWidth: 400, minHeight: 60, maxHeight: 60)
                    .padding(.horizontal)
                    .overlay(
                        Text(Strings.LOG_IN)
                            .foregroundColor(.white)
                            .font(.system(.title3, design: .rounded))
                            .bold()
                    ) // Overlay

            })
            .padding(.bottom)
            Button(action: {
                showSignupSheet = true
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(minWidth: 200, maxWidth: 400, minHeight: 60, maxHeight: 60)
                    .padding(.horizontal)
                    .overlay(
                        Text(Strings.SIGN_UP)
                            .foregroundColor(.white)
                            .font(.system(.title3, design: .rounded))
                            .bold()
                    ) // Overlay
            })
            .padding(.bottom)
        }
        .sheet(isPresented: $showLoginSheet, content: {
            LoginView(showing: $showLoginSheet).environmentObject(user)
        })
        .sheet(isPresented: $showSignupSheet, content: {
            SignupView(showing: $showLoginSheet).environmentObject(user)
        })
    } // Body
}

struct LoggedOutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoggedOutView()
                .environmentObject(UserViewModel())
        }
    }
}
