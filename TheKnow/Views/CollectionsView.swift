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
//        VStack {
//            NavigationView {
//                VStack {
//                    Text("Hello")
//                    Button(action: {
//                        presentAccountSheet.toggle()
//                    }) {
//                        Image(systemName: "person.circle")
//                            .font(.largeTitle)
//                    }
//                    .foregroundColor(.blue)
//                    .sheet(isPresented: $presentAccountSheet) {
//                        AccountView(showSheet: $presentAccountSheet)
//                    }
//                } // VStack
//            } // NavigationView
//        }// VStack
//        .environmentObject(user)


        NavigationView {
            List(0..<4) { index in
                NavigationLink(
                    destination: AccountView(),
                    label: {
                        Text("Collection \(index + 1)")
                            .font(.title2)
                    })
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        presentAccountSheet.toggle()
//                    }) {
//                        Image(systemName: "person.circle")
//                            .font(.largeTitle)
//                    }
//                    .foregroundColor(.blue)
//                    .sheet(isPresented: $presentAccountSheet) {
//                        AccountView(presented: $presentAccountSheet)
//                            .environmentObject(user)
//                    }
                    NavigationLink(destination: AccountView(), label: {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                    })
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
            .navigationTitle(Text(Strings.MY_COLLECTIONS))
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
            .environmentObject(UserViewModel())
    }
}
