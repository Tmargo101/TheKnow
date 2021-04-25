//
//  SignupView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var user: UserViewModel
    @ObservedObject private var signupViewModel = SignupViewModel()

    var body: some View {
        ZStack (alignment: .top){
            NavigationView {
                Form {
                    Section (header:
                                Text(Strings.USERNAME)
                             , footer:
                                Text(signupViewModel.usernameMessage)
                                    .foregroundColor(.red)
                    ) {
                        TextField(Strings.USERNAME, text: $signupViewModel.username)
                            .autocapitalization(.none)
                    } // Section
                    
                    Section (header:
                                Text(Strings.PASSWORD)
                             , footer:
                                Text(signupViewModel.passwordMessage)
                                    .foregroundColor(.red)
                        ) {
                        SecureField(Strings.ENTER_PASSWORD, text: $signupViewModel.password)
                            .autocapitalization(.none)
                        SecureField(Strings.VERIFY_PASSWORD, text: $signupViewModel.passwordConfirm)
                            .autocapitalization(.none)
                    } // Section
                    
                    Section {
                        Button(action: {
                            user.signup(_username: signupViewModel.username, password: signupViewModel.password, password2: signupViewModel.passwordConfirm)
                        }, label: {
                            Text(Strings.SIGN_UP)
                                .frame(maxWidth: .infinity, alignment: .center)
                        })
                        .disabled(!signupViewModel.isValid)
                    } // Section
                    
                } // Form
                .navigationTitle(Text(Strings.SIGN_UP))
            } // NavigationView
            Image(systemName: "chevron.compact.down")
                .font(.system(.largeTitle))
                .padding(.top, 20)
        } // ZStack
        
        
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
