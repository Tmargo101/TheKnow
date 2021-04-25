//
//  LoginViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
}
