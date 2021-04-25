//
//  SignupView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject private var loginViewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section (header: Text(Strings.USERNAME)) {
                    TextField(Strings.USERNAME, text: $loginViewModel.username)
                }
                Section (header: Text(Strings.PASSWORD)) {
                    TextField(Strings.ENTER_PASSWORD, text: $loginViewModel.password)
                    TextField(Strings.VERIFY_PASSWORD, text: $loginViewModel.password)
                }
                Section {
                        Button(action: {
    //                        self.signUp()
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
