//
//  AccountView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var user: UserViewModel
            
    var body: some View {
        ZStack (alignment: .top) {
            Form {
                Section (header: Text(Strings.ACCOUNT_NAME)) {
                    Text("\(user.username ?? Strings.USERNAME_NOT_FOUND)")
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
                        withAnimation {
                            user.logout()
                        }
                    }, label: {
                        Text(Strings.LOG_OUT)
                    })
                }
            }
            .navigationTitle(Strings.ACCOUNT)
        } // ZStack
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView(dismiss: true)
//            .environmentObject(UserViewModel())
//    }
//}
