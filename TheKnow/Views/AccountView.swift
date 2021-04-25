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
            NavigationView {
                Form {
                    Section (header: Text("Account Name")) {
//                        Text("\(user.username ?? "Username not found")")
                    }

                    Section (header: Text("Account Actions")) {
                        Button(action: {
                        }, label: {
                            Text("Change Password")
                        })

                        Button(action: {
                            user.logout()
                        }, label: {
                            Text("Log Out")
                        })
                    }
                }
                .navigationTitle("Account")
            }
            Image(systemName: "chevron.compact.down")
                .font(.system(.largeTitle))
                .padding(.top, 20)
        } // ZStack
        .environmentObject(user)
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//            .environmentObject(UserViewModel())
//    }
//}
