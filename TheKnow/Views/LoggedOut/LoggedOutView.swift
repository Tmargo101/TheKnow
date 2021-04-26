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
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .padding(.top, 50)
            Spacer()
            LoggedOutViewButtons(presentLoginSheet: $presentLoginSheet, presentSignupSheet: $presentSignupSheet)
                .environmentObject(user)
        }
        
    }
}

struct LoggedOutViewButtons: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @Binding var presentLoginSheet: Bool
    @Binding var presentSignupSheet: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.presentLoginSheet.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(minHeight: 60, maxHeight: 60)
                        .overlay(
                            Text(Strings.LOG_IN)
                                .foregroundColor(.white)
                                .font(.system(.title3, design: .rounded))
                                .bold()
                        )
                })
                .sheet(isPresented: $presentLoginSheet) {
                    LoginView()
                        .environmentObject(user)
                }
                
                Spacer()
            }
            HStack {
                Spacer()
                Button(action: {
                    self.presentSignupSheet.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(minHeight: 60, maxHeight: 60)
                        .overlay(
                            Text(Strings.SIGN_UP)
                                .foregroundColor(.white)
                                .font(.system(.title3, design: .rounded))
                                .bold()
                        )

                })
                .sheet(isPresented: $presentSignupSheet) {
                    SignupView()
                        .environmentObject(user)
                }

                Spacer()
            }
        }
        .padding(.bottom, 50)        
    }
}

struct LoggedOutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoggedOutView()
                .environmentObject(UserViewModel())
        }
    }
}
