//
//  AddPlaceView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI


struct AddPlaceView: View {
    var token: String = ""
    var userId: String = ""
    var collectionId: String = ""
    var fullName: String = ""
    
    @State var showError: Bool = false
    
//    @State var location: String
    @Binding var isShow: Bool
    
    @State var isEditing = false
    @ObservedObject var searchMe = SearchMe()
    @State var reccomendedBy: String = ""
    @State var note: String = ""
    
    @State var showSuggestions: Bool = false
    
    @ObservedObject var addPlaceViewModel = AddPlaceViewModel()

    //@State var searchResults: [PlaceSearchResultModel] = []
//    init() {
//        UITextView.appearance().backgroundColor = .clear
//    }
//
    var body: some View {
        ZStack (alignment: .top){
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
                                .foregroundColor(.primary)
                                .font(.headline)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                    SearchBar(text: $addPlaceViewModel.newPlaceName, isEditing: $isEditing, searchMe: searchMe)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .padding(.bottom)
                        .onTapGesture {
                            showSuggestions = true
                        }
                        
                    if !searchMe.placeSearchResults.isEmpty && showSuggestions {
                        List {
                            ForEach (searchMe.placeSearchResults) { sr in
                                VStack(alignment: .leading) {
                                    Button(action: {
                                        addPlaceViewModel.newPlaceAddress = sr.address
                                        addPlaceViewModel.newPlacePhoneNumber = sr.phoneNumber ?? ""
                                        addPlaceViewModel.newPlaceLink = sr.url?.absoluteString ?? ""
                                        addPlaceViewModel.newPlaceName = sr.name
                                        searchMe.placeSearchResults = []
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        showSuggestions = false

                                    }, label: {
                                        VStack(alignment: .leading) {
                                            Text("\(sr.name)")
                                                .font(.headline)
                                                .padding(.bottom, 3)
                                            Text("\(sr.address)")
                                                .font(.subheadline)
                                                .padding(.bottom, 2)
                                        }

                                    })
                                }
                                
                            }
                        }
                    }
                    TextField("Reccomended By", text: $addPlaceViewModel.newPlaceRecommendedBy)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .padding(.bottom)
                    TextField("Note", text: $addPlaceViewModel.newPlaceNote)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .padding(.bottom)

//                    TextEditor(text: $addPlaceViewModel.newPlaceNote)
//                        .frame(minHeight: 50, maxHeight: 200)
//                        .padding()
//                        .padding(.top, 20)
//                        .background(Color(.systemGray5))
//                        .cornerRadius(8)
//                        .padding(.bottom)
//                        .font(.system(size: 20, design: .rounded))

                    HStack {
                        Toggle(isOn: $addPlaceViewModel.newPlaceBeen) {
                            Text("")
                        }
                            .toggleStyle(CheckboxStyle())
                            .padding()
                        Text("Have you been here yet?")
                            .font(.system(size: 20, design: .rounded))
                            .foregroundColor(Color(.systemGray))
                        Spacer()
                    }
                    Spacer()
                    VStack (alignment: .leading) {
                        HStack {
                            Spacer()
                            Text("Place Data:")
                                .padding()
                            Spacer()
                        }
                        HStack {
                            Text("Address: \(addPlaceViewModel.newPlaceAddress)")
                                .padding(.bottom, 4)
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(Color(.systemGray2))
                            Spacer()
                        }
                        HStack {
                            Text("Phone Number: \(addPlaceViewModel.newPlacePhoneNumber)")
                                .padding(.bottom, 4)
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(Color(.systemGray2))
                            Spacer()
                        }
                        HStack {
                            Text("Link: \(addPlaceViewModel.newPlaceLink)")
                                .padding(.bottom, 4)
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(Color(.systemGray2))
                            Spacer()
                        }
                    }
                    .background(Color(.systemGray5))
                    .cornerRadius(10.0)
                    
                    // Save button for adding the  item
                    Button(action: {
//                        if self.addPlaceViewModel.newPlaceName.trimmingCharacters(in: .whitespaces) == "" {
//                            return
//                        }
                        addPlaceViewModel.addPlace(
                            token: token,
                            addedBy: userId,
                            collectionId: collectionId,
                            fullName: fullName
                        ) { success in
                            print(success)
                            if (success) {
                                self.isShow = false
                            } else {
                                self.showError = true
                            }
                        }
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
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error adding place"), message: Text("\(addPlaceViewModel.responseMessage)"), dismissButton: .default(Text("Close")))
                }
                .onAppear() {
                    // Make the note field clear so the background works
                    UITextView.appearance().backgroundColor = .clear
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10, antialiased: true)
    //            .offset(y: isEditing ? -320 : 0)
            }
            .edgesIgnoringSafeArea(.bottom)
            Image(systemName: "chevron.compact.down")
                .foregroundColor(Color(.systemGray5))
                .font(.system(.largeTitle))
                .padding(.top, 15)
        }
    }
}

//https://www.appcoda.com/swiftui-search-bar/
struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @ObservedObject var searchMe: SearchMe
    
    var body: some View {
        HStack {
            
            TextField("Name", text: $text, onEditingChanged: {
                (ec) in
                self.isEditing = ec
            })
            .background(Color(.systemGray5))
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
    //
    //struct AddPlaceView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        AddPlaceView(location: "", isShow: .constant(true))
    //    }
    //}

struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(configuration.isOn ? .green : .gray)
                .font(.system(size: 32, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }

    }
}
