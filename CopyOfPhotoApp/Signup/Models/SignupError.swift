//
//  SignupError.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 22/02/23.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
    
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case invalidRepeatedPassword
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel, .invalidRequestURLString, .invalidFirstName, .invalidLastName, .invalidEmail, .invalidPassword, .invalidRepeatedPassword:
            return ""
        }
        
    }
    
}
