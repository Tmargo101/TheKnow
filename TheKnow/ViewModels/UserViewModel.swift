//
//  UserViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation
import Alamofire

class UserViewModel: ObservableObject {
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
        .responseJSON { response in
            print(response)
        }
        .responseDecodable(of: Response.self) { (response) in
            guard let response = response.value else { return }
            self.token = response.contents.user?.token
            self.id = response.contents.user?.id
            self.username = _username
            self.loggedIn = true
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
        .responseJSON { response in
            print(response)
        }
        .responseDecodable(of: Response.self) { (response) in
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
            .responseDecodable(of: Response.self) { (response) in
                guard response.value != nil else { return }
                self.username = ""
                self.id = ""
                self.token = ""
                self.loggedIn = false
            }
    }
}
