//
//  UserViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var loggedIn: Bool = false
    @Published var username: String = ""
    @Published var token: String = ""
    
    func login(username: String, password: String) {
        print("Username: \(username), Password: \(password)")
        self.loggedIn.toggle()
    }
    
    func signup(username: String, password: String, password2: String) {
        print("Username: \(username), Password: \(password)")
        self.loggedIn.toggle()
    }
    
    func logout() {
        self.loggedIn.toggle()
    }
}
