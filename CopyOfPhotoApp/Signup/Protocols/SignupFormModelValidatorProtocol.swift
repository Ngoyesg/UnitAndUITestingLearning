//
//  SignupModelValidatorProtocol.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 23/02/23.
//

import Foundation

protocol SignupFormModelValidatorProtocol {
    func isNameValid(_ name: String) -> Bool
    func isLastNameValid(_ name: String) -> Bool
    func isEmailValid(_ email: String) -> Bool
    func isPasswordValid(_ password: String) -> Bool
    func doPasswordsMatch(_ password: String, _ repeatedPassword: String) -> Bool
}
