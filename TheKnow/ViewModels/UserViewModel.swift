//
//  UserViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation
import Alamofire

class UserViewModel: ObservableObject {
    
    let defaults = UserDefaults.standard

    @Published var loggedIn: Bool = false
    @Published var username: String? = ""
    @Published var id: String? = ""
    @Published var token: String? = ""
    
    func login(_username: String, password: String) {
        let parameters = [
            "username": _username,
            "password": password
        ]
        AF.request(Routes.LOGIN,
                   method: .post,
                   parameters: parameters
        )
        .validate()
        .responseDecodable(of: APIResponse.self) { (response) in
            guard let response = response.value else { return }
            
            /// Add userData to object
            self.token = response.contents.user?.token
            self.id = response.contents.user?.id
            self.username = _username
            self.loggedIn = true
            
            /// Add userData to UserDefaults
            self.defaults.set(self.token, forKey: "token")
            self.defaults.set(self.loggedIn, forKey: "loggedIn")
            self.defaults.set(self.username, forKey: "username")
            self.defaults.set(self.id, forKey: "id")
        }
    }
    
    func signup(_username: String, password: String, password2: String) {
        print("Username: \(_username), Password: \(password)")
        let parameters = [
            "username": _username,
            "pass": password,
            "pass2": password2,
        ]

        AF.request(Routes.SIGNUP,
                   method: .post,
                   parameters: parameters
        )
        .validate()
        .responseDecodable(of: APIResponse.self) { (response) in
            guard let response = response.value else { return }
            print(response)
            self.token = response.contents.user?.token
            self.id = response.contents.user?.id
            self.username = _username
            self.loggedIn = true
        }
    }
    
    func logout() {
        let headers: HTTPHeaders = [Headers.AUTH: self.token ?? ""]
        AF.request(Routes.LOGOUT ,method: .post, headers: headers)
            .validate()
            .responseDecodable(of: APIResponse.self) { (response) in
                guard response.value != nil else { return }
                
                /// Remove user details
                self.username = ""
                self.id = ""
                self.token = ""
                self.loggedIn = false
                
                /// Remove from UserDefaults
                self.defaults.set(self.token, forKey: "token")
                self.defaults.set(self.loggedIn, forKey: "loggedIn")
                self.defaults.set(self.username, forKey: "username")
                self.defaults.set(self.id, forKey: "id")
            }
    }
}
