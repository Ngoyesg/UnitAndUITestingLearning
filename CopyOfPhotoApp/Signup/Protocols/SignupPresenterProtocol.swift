//
//  SignupPresenterProtocol.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 23/02/23.
//

import Foundation

protocol SignupPresenterProtocol {
    
    init(formModelValidator: SignupFormModelValidatorProtocol, webService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol)
    
    func processUserSignup(formModel: SignupFormModel)
    
}
