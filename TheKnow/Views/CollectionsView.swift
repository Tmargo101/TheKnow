//
//  CollectionsView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import SwiftUI

struct CollectionsView: View {
    
    @EnvironmentObject var user: UserViewModel
    
    @State var presentAccountSheet: Bool = false
    
    var body: some View {
        NavigationView {
            List(0..<4) { index in
                NavigationLink(
                    destination: Text("Collection \(index)"),
                    label: {
                        Text("Collection \(index + 1)")
                            .font(.title2)
                    })
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        user.accountSheet.toggle()
                    }) {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                    }
                    .foregroundColor(.blue)
                    .sheet(isPresented: $user.accountSheet) {
                        AccountView()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("TheKnow")
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                    })
                    .foregroundColor(.blue)
                } // ToolbarItem
            } //Toolbar
            .navigationBarTitle(Strings.MY_COLLECTIONS)
            //.navigationTitle(Strings.MY_COLLECTIONS)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(user)
        
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
            .environmentObject(UserViewModel())
    }
}
