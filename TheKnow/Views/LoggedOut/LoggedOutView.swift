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
//        NavigationView {
            VStack {
                Text(Strings.LOGGED_OUT_WELCOME)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .padding(.top, 50)
                Spacer()
                LoggedOutViewButtons()
            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())

        
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
//            NavigationLink(
//                destination: LoginView(),
//                label: {
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(minWidth: 200, maxWidth: 400, minHeight: 60, maxHeight: 60)
//                        .padding(.horizontal)
//                        .overlay(
//                            Text(Strings.LOG_IN)
//                                .foregroundColor(.white)
//                                .font(.system(.title3, design: .rounded))
//                                .bold()
//                        ) // Overlay
//            }) // NavigationLink
//                .padding(.bottom)
//            NavigationLink(
//                destination: SignupView(),
//                label: {
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(minWidth: 200, maxWidth: 400, minHeight: 60, maxHeight: 60)
//                        .padding(.horizontal)
//                        .overlay(
//                            Text(Strings.SIGN_UP)
//                                .foregroundColor(.white)
//                                .font(.system(.title3, design: .rounded))
//                                .bold()
//                        ) // Overlay
//            }) // NavigationLink
//                .padding(.bottom)
//        }
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
