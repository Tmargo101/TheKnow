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
    @Binding var showing: Bool

    var body: some View {
        ZStack (alignment: .top){
            NavigationView {
                Form {
                    Section (header:
                                Text(Strings.EMAIL)
                             , footer:
                                Text(signupViewModel.emailMessage)
                                    .foregroundColor(.red)
                    ) {
                        TextField(
                            Strings.EMAIL,
                            text: $signupViewModel.email,
                            onEditingChanged: { _ in
                                signupViewModel.validateEmail()
                            }
                        )
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    } // Section
                    
                    Section (header:
                                Text("Name")
                             , footer:
                                Text(signupViewModel.nameMessage)
                                    .foregroundColor(.red)
                        ) {
                        TextField(
                            "First Name",
                            text: $signupViewModel.firstname,
                            onEditingChanged: { _ in
                                signupViewModel.validateName()
                            }
                        )
                        .disableAutocorrection(true)
                        TextField(
                            "Last Name",
                            text: $signupViewModel.lastname,
                            onEditingChanged: { _ in
                                signupViewModel.validateSignup()
                            }
                        )
                        
                        .disableAutocorrection(true)
                    } // Section

                    
                    Section (header:
                                Text(Strings.PASSWORD)
                             , footer:
                                Text(signupViewModel.passwordMessage)
                                    .foregroundColor(.red)
                        ) {
                        SecureField(
                            Strings.ENTER_PASSWORD,
                            text: $signupViewModel.password
                        )
                        .autocapitalization(.none)
                        .onTapGesture {
                            signupViewModel.validatePassword()
                        }
                        SecureField(
                            Strings.VERIFY_PASSWORD,
                            text: $signupViewModel.passwordConfirm
                        )
                        .autocapitalization(.none)
                        .onTapGesture {
                            signupViewModel.validatePassword()
                        }
                    } // Section
                    
                    Section {
                        Button(action: {
                            performSignup()
                        }, label: {
                            Text(Strings.SIGN_UP)
                                .frame(maxWidth: .infinity, alignment: .center)
                        })
                        .disabled(!signupViewModel.isValid)
                    } // Section
                    
                } // Form
                .navigationTitle(Text(Strings.SIGN_UP))
                Image(systemName: "chevron.compact.down")
                    .foregroundColor(Color(.systemGray3))
                    .font(.system(.largeTitle))
                    .padding(.top, 15)

            }
        } // ZStack
    } // Body
    
    func performSignup() {
        
        user.signup(
            _email: signupViewModel.email,
            firstname: signupViewModel.firstname,
            lastname: signupViewModel.lastname,
            password: signupViewModel.password,
            password2: signupViewModel.passwordConfirm
        ) { (success) in
            if (success) {
                showing = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation {
                        user.loggedIn = true
                    }
                }
            }
        } // user.signup
    }
}

//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView()
//    }
//}
