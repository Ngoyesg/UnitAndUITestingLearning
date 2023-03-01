//
//  SignupPresenter.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 23/02/23.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol {
    
    private var signupFormModelValidator: SignupFormModelValidatorProtocol

    private var webService: SignupWebServiceProtocol
   
    private weak var delegate: SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupFormModelValidatorProtocol, webService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        self.signupFormModelValidator = formModelValidator
        self.webService = webService
        self.delegate = delegate
    }
    
    
    func processUserSignup(formModel: SignupFormModel) {
        
        if !signupFormModelValidator.isNameValid(formModel.firstName){
            delegate?.errorHandler(error: SignupError.invalidFirstName)
            return
        }
        if !signupFormModelValidator.isLastNameValid(formModel.lastName){
            delegate?.errorHandler(error: SignupError.invalidLastName)
            return
        }
        if !signupFormModelValidator.isEmailValid(formModel.email){
            delegate?.errorHandler(error: SignupError.invalidEmail)
            return
        }
        if !signupFormModelValidator.isPasswordValid(formModel.password){
            delegate?.errorHandler(error: SignupError.invalidPassword)
            return
        }
        if !signupFormModelValidator.doPasswordsMatch(formModel.password, formModel.repeatPassword){
            delegate?.errorHandler(error: SignupError.invalidRepeatedPassword)
            return
        }
        
        let requestModel = SignupFormRequestModel(firstName: formModel.firstName, lastName: formModel.lastName, email: formModel.email, password: formModel.password)
        
        webService.signup(withForm: requestModel) { [weak self] (responseModel, error) in
            
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            
            if let _ = responseModel {
                self?.delegate?.successfulSignup()
                return
            }
        }
    }
}
