//
//  LoginView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var user: UserViewModel
    @ObservedObject private var loginViewModel = LoginViewModel()
    @Binding var showing: Bool

    var body: some View {
        ZStack (alignment: .top) {
            NavigationView {
                Form {
                    Section {
                        TextField(Strings.EMAIL, text: $loginViewModel.email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                        SecureField(Strings.PASSWORD, text: $loginViewModel.password) {
                            performLogin()
                        }
                        .autocapitalization(.none)
                        .keyboardType(.default)
                            

                    }
                    Section {
                        Button(action: {
                            performLogin()
                        }, label: {
                            Text(Strings.LOG_IN)
                                .frame(maxWidth: .infinity, alignment: .center)
                        })
                        .disabled(!loginViewModel.isValid)
                    } // Section
                } // Form
                .navigationTitle(Text(Strings.LOG_IN))
            }
            Image(systemName: "chevron.compact.down")
                .foregroundColor(Color(.systemGray3))
                .font(.system(.largeTitle))
                .padding(.top, 15)

        } // ZStack
    } // Body
    
    func performLogin() {
//        if(loginViewModel.isValid) {
            user.login(_email: loginViewModel.email, password: loginViewModel.password) { (success) in
                if (success) {
                    showing = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        withAnimation {
                            user.loggedIn = true
                        }
                    }
                }
            }
//        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
