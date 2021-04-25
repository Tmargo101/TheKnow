//
//  UserViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var loggedIn: Bool = false
    @Published var username: String? = ""
    @Published var token: String? = ""
    
    func login(_username: String, password: String) {
        print("Username: \(_username), Password: \(password)")
        self.username = _username
        self.loggedIn = true
    }
    
    func signup(_username: String, password: String, password2: String) {
        print("Username: \(_username), Password: \(password)")
        self.username = _username
        self.loggedIn = true
    }
    
    func logout() {
        print("Logout")
        self.loggedIn = false
    }
}
