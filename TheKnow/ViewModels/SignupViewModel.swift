//
//  SignupViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    
    @Published var emailMessage: String = ""
    @Published var nameMessage: String = ""
    @Published var passwordMessage: String = ""
    @Published var isValid: Bool = false

    var cancellableSet: Set<AnyCancellable> = []

    var isEmailValidPublisher: AnyPublisher<Bool,Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    var isNameValidPublisher: AnyPublisher<Bool,Never> {
        Publishers.CombineLatest($firstname, $lastname)
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map {firstname, lastname in
                let first = firstname.count >= 1
                let last = lastname.count >= 1
                return first && last
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
        Publishers.CombineLatest3(isEmailValidPublisher, isNameValidPublisher, isPasswordValidPublisher)
            .map { usernameIsValid, nameIsValid, passwordIsValid in
                return usernameIsValid && nameIsValid && (passwordIsValid == .valid)
            }
            .eraseToAnyPublisher()
    }

    func validateEmail() {
        isEmailValidPublisher
            .receive(on: RunLoop.main)
            .map {
                valid in
                valid ? "" : "Entry must be an email"
            }
            .assign(to: \.emailMessage, on: self)
            .store(in: &cancellableSet)
    }
    
    func validateName() {
        isNameValidPublisher
            .receive(on: RunLoop.main)
            .map {
                valid in
                valid ? "" : "Enter a first and last name"
            }
            .assign(to: \.nameMessage, on: self)
            .store(in: &cancellableSet)

    }
    
    func validatePassword() {
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
    }
    
    func validateSignup() {
        /// Check if the form is valid to eanble / disable the button
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
//        /// Check if username is valid
//        isEmailValidPublisher
//            .receive(on: RunLoop.main)
//            .map {
//                valid in
//                valid ? "" : "Entry must be an email"
//            }
//            .assign(to: \.emailMessage, on: self)
//            .store(in: &cancellableSet)
        
//        isNameValidPublisher
//            .receive(on: RunLoop.main)
//            .map {
//                valid in
//                valid ? "" : "Enter a first and last name"
//            }
//            .assign(to: \.nameMessage, on: self)
//            .store(in: &cancellableSet)

//        isPasswordValidPublisher
//            .receive(on: RunLoop.main)
//            .map { passwordCheck in
//                switch passwordCheck {
//                    case .empty:
//                        return "Password must not be empty"
//                    case .notMatching:
//                        return "Passwords don't match"
//                    default:
//                        return ""
//                }
//            }
//            .assign(to: \.passwordMessage, on: self)
//            .store(in: &cancellableSet)
    } // Init

}
