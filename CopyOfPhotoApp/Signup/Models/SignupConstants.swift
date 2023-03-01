//
//  SignupConstants.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 21/02/23.
//

import Foundation

struct SignupConstants {
    static let nameMinLength = 2
    static let nameMaxLength = 15
    static let nameValidLengthRange = (nameMinLength..<nameMaxLength)
    static let emailAtSymbol = "@"
    static let emailMinLength = 5
    static let emailMaxLength = 30
    static let emailValidLengthRange = (emailMinLength..<emailMaxLength)
    static let passwordMinLength = 8
    static let passwordMaxLength = 30
    static let passwordValidLengthRange = (passwordMinLength..<passwordMaxLength)
    static let signupURL = "https://tlyqhtlbn8.execute-api.us-east-1.amazonaws.com/prod/signup-mock-service/users"
}
