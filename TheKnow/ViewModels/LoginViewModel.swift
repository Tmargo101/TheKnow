//
//  LoginViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isValid: Bool = false
    
    var cancellableSet: Set<AnyCancellable> = []
    
    var isUsernameValidPublisher: AnyPublisher<Bool,Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password == ""
            }
            .eraseToAnyPublisher()
    } // isPasswordEmptyPublisher
        
    var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordEmptyPublisher)
            .map { usernameIsValid, passwordIsEmpty in
                return usernameIsValid && !passwordIsEmpty
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        /// Check if the form is valid to eanble / disable the button
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }


}

