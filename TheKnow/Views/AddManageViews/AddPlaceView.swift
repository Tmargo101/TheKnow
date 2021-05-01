//
//  AddPlaceView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI


struct AddPlaceView: View {
    @State var location: String
    @Binding var isShow: Bool
    @State var isEditing = false
    @ObservedObject var searchMe = SearchMe()

    //@State var searchResults: [PlaceSearchResultModel] = []
    
    
    var body: some View {
        VStack {
//            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Add a New Place")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        self.isShow = false
                        
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                
                SearchBar(text: $location, isEditing: $isEditing, searchMe: searchMe)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom)
                    
                if !searchMe.placeSearchResults.isEmpty {
                    List {
                        ForEach (searchMe.placeSearchResults) { sr in
                            VStack(alignment: .leading) {
                                Text("\(sr.name)")
                                    .font(.headline)
                                    .padding(.bottom, 3)
                                Text("\(sr.address)")
                                    .font(.subheadline)
                            }
                            
                        }
                    }
                }

                    
                Spacer()
                // Save button for adding the  item
                Button(action: {
                    if self.location.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    self.isShow = false
                    
                    //add code to add collection here
                    
                }) {
                    Text("Save")
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
//            .offset(y: isEditing ? -320 : 0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}



struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceView(location: "", isShow: .constant(true))
    }
}

//https://www.appcoda.com/swiftui-search-bar/
struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @ObservedObject var searchMe: SearchMe
    
    var body: some View {
        HStack {
            
            TextField("Search...", text: $text, onEditingChanged: {
                (ec) in
                self.isEditing = ec
            })
            .onChange(of: text, perform: { _ in
                searchMe.search(search: text)
                print("fired")
                print(searchMe.placeSearchResults)
            })
            .overlay(
                HStack {
                    Spacer()
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.text = ""
                            searchMe.placeSearchResults = []
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
//                                Image(systemName: "multiply.circle.fill")
//                                    .foregroundColor(.gray)
//                                    .padding(.trailing, 8)
                            Text("Cancel")
                        }
                        .transition(.move(edge: .trailing))
                        .animation(.default)

                    }
                }

            )


//                .padding(7)
//                .padding(.horizontal, 25)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .overlay(
//                )
//                .onChange(of: text, perform: { _ in
//                    searchMe.search(search: text)
//                    print("fired")
//                    print(searchMe.placeSearchResults)
//                })
        }
    } // Body
}
