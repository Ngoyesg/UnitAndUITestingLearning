//
//  SignupViewDelegateProtocol.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 23/02/23.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    
    func successfulSignup()
    func errorHandler(error: SignupError)
    
    
}
