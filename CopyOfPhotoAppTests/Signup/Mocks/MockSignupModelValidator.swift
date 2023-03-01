//
//  MockSignupModelValidator.swift
//  CopyOfPhotoAppTests
//
//  Created by Natalia Goyes on 23/02/23.
//

import Foundation
@testable import CopyOfPhotoApp

class MockSignupModelValidator: SignupFormModelValidatorProtocol {

    var isFirstNameValidated: Bool = false
    var isLastNameValidated: Bool = false
    var isEmailValidated: Bool = false
    var isPasswordValidated: Bool = false
    var isPasswordEqualityValidated: Bool = false

    func isNameValid(_ name: String) -> Bool {
        isFirstNameValidated = true
        return isFirstNameValidated
    }
    
    func isLastNameValid(_ name: String) -> Bool {
        isLastNameValidated = true
        return isLastNameValidated
    }
    
    func isEmailValid(_ email: String) -> Bool {
        isEmailValidated = true
        return isEmailValidated

    }
    
    func isPasswordValid(_ password: String) -> Bool {
        isPasswordValidated = true
        return isPasswordValidated
    }
    
    func doPasswordsMatch(_ password: String, _ repeatedPassword: String) -> Bool {
        isPasswordEqualityValidated = true
        return isPasswordEqualityValidated
    }
    
    
    
}
