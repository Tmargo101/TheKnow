//
//  SignupViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    
    @Published var usernameMessage: String = ""
    @Published var passwordMessage: String = ""
    @Published var isValid: Bool = false

    var cancellableSet: Set<AnyCancellable> = []

    var isUsernameValidPublisher: AnyPublisher<Bool,Never> {
        $username
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
    }
    
    var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        /// Receives and combines the latest publsehd values for both of these values
        Publishers.CombineLatest($password, $passwordConfirm)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { password, passwordConfirm in
                return password == passwordConfirm
            }
            .eraseToAnyPublisher()
    }
    
    enum PasswordCheck {
        case valid
        case empty
        case notMatching
    }

    
    var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest(isPasswordEmptyPublisher, arePasswordsEqualPublisher)
            .map { passwordIsEmpty, passwordsAreEqual in
                if (passwordIsEmpty) {
                    return .empty
                }
                if (!passwordsAreEqual) {
                    return .notMatching
                }
                return .valid
            }
            .eraseToAnyPublisher()
    }
    
    var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
            .map { usernameIsValid, passwordIsValid in
                return usernameIsValid && (passwordIsValid == .valid)
            }
            .eraseToAnyPublisher()
    }

    init() {
        /// Check if the form is valid to eanble / disable the button
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
        /// Check if username is valid
        isUsernameValidPublisher
            .receive(on: RunLoop.main)
            .map {
                valid in
                valid ? "" : "username must contain at least 3 characters"
            }
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                switch passwordCheck {
                    case .empty:
                        return "Password must not be empty"
                    case .notMatching:
                        return "Passwords don't match"
                    default:
                        return ""
                }
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
    } // Init

}
