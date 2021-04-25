//
//  SignupView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var user: UserViewModel
    @ObservedObject private var loginViewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section (header: Text(Strings.USERNAME)) {
                    TextField(Strings.USERNAME, text: $loginViewModel.username)
                }
                Section (header: Text(Strings.PASSWORD)) {
                    SecureField(Strings.ENTER_PASSWORD, text: $loginViewModel.password)
                    SecureField(Strings.VERIFY_PASSWORD, text: $loginViewModel.password)
                }
                Section {
                        Button(action: {
                            user.loggedIn.toggle()
                        }, label: {
                            Text(Strings.SIGN_UP)
                                .frame(maxWidth: .infinity, alignment: .center)
                        })
    //                    .disabled(userViewModel.isValid)
                }
            }
            .navigationTitle(Strings.SIGN_UP)
        }
        
        
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
