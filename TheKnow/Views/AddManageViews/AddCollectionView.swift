//
//  AddCollectionView.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/26/21.
//

import SwiftUI

struct AddCollectionView: View {
    @State var name: String
    @Binding var isShow: Bool
    @State var isEditing = false
    
    @ObservedObject var addCollectionViewModel = AddCollectionViewModel()
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Add a New Collection")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.isShow = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.primary)
                            .font(.headline)
                    }
                }
                
                TextField("Enter the collection name", text: $addCollectionViewModel.newCollectionName, onEditingChanged: { (editingChanged) in
                    
                    self.isEditing = editingChanged
                    
                })
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.bottom)
                
                // Save button for adding the  item
                Button(action: {
                    
                    if self.name.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    addCollectionViewModel.addNewCollection(_name: addCollectionViewModel.newCollectionName, usedId: user.id ?? "", token: user.token ?? "") { success in
                        print(success)
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
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10, antialiased: true)
            .offset(y: isEditing ? -320 : 0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct AddCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddCollectionView(name: "", isShow: .constant(true))
    }
}
