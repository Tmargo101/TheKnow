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
    
    @Published var dev = true

    @Published var loggedIn: Bool = true
    
    @Published var showAccountSheet: Bool = false
    
    @Published var email: String? = "tmargo101@gmail.com"
    @Published var id: String? = "6090677510b4180015de0fc5"
    @Published var token: String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOTA2Nzc1MTBiNDE4MDAxNWRlMGZjNSIsImlhdCI6MTYyMDc4MTQ5NCwiZXhwIjoxNjI4NTU3NDk0fQ.1EPXnJgVJ6k0eoJU7ayb4eYCmhcQAUTSJlTw6Wxophs"
    
    @Published var responseMessage: String = ""
    
    func login(_email: String, password: String, completion: @escaping (Bool) -> Void) {
        let parameters = [
            "email": _email,
            "password": password
        ]
        AF.request(Routes.LOGIN,
                   method: .post,
                   parameters: parameters
        )
//        .validate()
        .responseDecodable(of: APIResponse.self) { (response) in
            guard let response = response.value else {
                print(response)
                completion(false)
                return
            }
            
            if (response.status == "error") {
                self.responseMessage = response.message
                completion(false)
                return
            }
            
            /// Add userData to object
            self.token = response.contents?.user?.token
            self.id = response.contents?.user?._id
            self.email = _email
            
            /// Add userData to UserDefaults
            self.defaults.set(self.token, forKey: "token")
            self.defaults.set(self.loggedIn, forKey: "loggedIn")
            self.defaults.set(self.email, forKey: "email")
            self.defaults.set(self.id, forKey: "id")
            
            completion(true)
        }
    }
    
    func signup(_email: String, firstname: String, lastname: String, password: String, password2: String, completion: @escaping (Bool) -> Void) {
        print("Email: \(_email), Password: \(password)")
        let parameters = [
            BodyParams.EMAIL: _email,
            BodyParams.FIRSTNAME: firstname,
            BodyParams.LASTNAME: lastname,
            BodyParams.PASSWORD: password,
            BodyParams.PASSWORD_CONFIRM: password2,
        ]
        AF.request(Routes.SIGNUP,
                   method: .post,
                   parameters: parameters
        )
        .responseDecodable(of: APIResponse.self) { (response) in
            guard let response = response.value else {
                completion(false)
                return
            }
            self.token = response.contents?.user?.token
            self.id = response.contents?.user?._id
            self.email = _email
            completion(true)
            
        }
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [Headers.AUTH: self.token ?? ""]
        AF.request(Routes.LOGOUT ,method: .post, headers: headers)
            .validate()
            .responseDecodable(of: APIResponse.self) { (response) in
                guard response.value != nil else {
                    completion(false)
                    return
                }
                
                /// Remove user details
                self.email = ""
                self.id = ""
                self.token = ""
                
                /// Remove from UserDefaults
                self.defaults.set(self.token, forKey: "token")
//                self.defaults.set(self.loggedIn, forKey: "loggedIn")
                self.defaults.set(self.email, forKey: "email")
                self.defaults.set(self.id, forKey: "id")
                
                completion(true)
            }
    }
}
