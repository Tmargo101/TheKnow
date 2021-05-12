//
//  AccountView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var user: UserViewModel
    @ObservedObject var accountViewModel = AccountViewModel()
    
    @Binding var showing: Bool
    
    var body: some View {
        ZStack (alignment: .top) {
            NavigationView {
                Form {
                    Section (header: Text(Strings.ACCOUNT_NAME)) {
                        Text("\(user.email ?? Strings.USERNAME_NOT_FOUND)")
                    }
                    Section (header: Text("Devices signed in")) {
                        Text("\(accountViewModel.Account.tokenCount )")
                    }
                    Section (header: Text("Name")) {
                        Text("\(accountViewModel.Account.name.first) \(accountViewModel.Account.name.last)")
                    }
                    Section (header: Text("User ID (DEV)")) {
                        Text("\(user.id ?? Strings.USERNAME_NOT_FOUND)")
                    }
                    Section (header: Text("Current Token (DEV)")) {
                        Text("\(user.token ?? Strings.USERNAME_NOT_FOUND)")
                    }

                    Section (header: Text(Strings.ACCOUNT_ACTIONS)) {
                        Button(action: {
                            
                        }, label: {
                            Text(Strings.CHANGE_PASSWORD)
                        })
                        .disabled(true)

                        Button(action: {
                            performLogout()
                        }, label: {
                            Text(Strings.LOG_OUT)
                        })
                    }
                }
                .onAppear(perform: {
                    accountViewModel.getUser(token: user.token)
                })
                .navigationTitle(Strings.ACCOUNT)

            }
            Image(systemName: "chevron.compact.down")
                .foregroundColor(Color(.systemGray3))
                .font(.system(.largeTitle))
                .padding(.top, 15)

        } // ZStack
    }
    
    func performLogout() {
        user.logout() { (success) in
            if (success) {
                showing = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation {
                        user.setLoggedIn(status: false)
                    }
                }
            }
        }

    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView(dismiss: true)
//            .environmentObject(UserViewModel())
//    }
//}
