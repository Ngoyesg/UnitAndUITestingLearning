//
//  SignupFormValidator.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 21/02/23.
//

import Foundation

class SignupFormValidator: SignupFormModelValidatorProtocol {
    
    
    func isNameValid(_ name: String) -> Bool
    {
        let isNameEmpty = name.isEmpty
        let isNameLengthValid = SignupConstants.nameValidLengthRange.contains(name.count)
        return !isNameEmpty && isNameLengthValid
    }
    
    func isLastNameValid(_ lastName: String) -> Bool
    {
        let isLastNameEmpty = lastName.isEmpty
        let isLastNameLengthValid = SignupConstants.nameValidLengthRange.contains(lastName.count)
        return !isLastNameEmpty && isLastNameLengthValid
    }
    
    func isEmailValid(_ email: String) -> Bool
    {
        let isAtSymbolProvided = Array(email).contains(SignupConstants.emailAtSymbol)
        let isEmailLengthValid = SignupConstants.emailValidLengthRange.contains(email.count)
        return isAtSymbolProvided && isEmailLengthValid
    }
    
    func isPasswordValid(_ password: String) -> Bool
    {
        let isPasswordLengthValid = SignupConstants.passwordValidLengthRange.contains(password.count)
        return !password.isEmpty && isPasswordLengthValid
    }
    
    func doPasswordsMatch(_ password: String, _ repeatedPassword: String) -> Bool
    {
        return password == repeatedPassword
    }
    
}
