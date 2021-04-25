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
}
