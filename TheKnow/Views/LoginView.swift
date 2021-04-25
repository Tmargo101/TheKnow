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

    var body: some View {
        NavigationView {
            Form {
                Section () {
                    TextField(Strings.USERNAME, text: $loginViewModel.username)
                        .autocapitalization(.none)
                    SecureField(Strings.PASSWORD, text: $loginViewModel.password)

                }
                Section {
                        Button(action: {
                            user.login(username: loginViewModel.username, password: loginViewModel.password)
                        }, label: {
                            Text(Strings.LOG_IN)
                                .frame(maxWidth: .infinity, alignment: .center)
                        })
    //                    .disabled(userViewModel.isValid)
                }
            }
            .navigationTitle("Log In")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
