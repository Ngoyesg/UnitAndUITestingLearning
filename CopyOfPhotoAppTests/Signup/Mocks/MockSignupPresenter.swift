//
//  MockSignupPresenter.swift
//  CopyOfPhotoAppTests
//
//  Created by Natalia Goyes on 23/02/23.
//

import Foundation
@testable import CopyOfPhotoApp


class MockSignupPresenter: SignupPresenterProtocol {
    
    var processUserSignupCalled: Bool = false
    
    required init(formModelValidator: CopyOfPhotoApp.SignupFormModelValidatorProtocol, webService: CopyOfPhotoApp.SignupWebServiceProtocol, delegate: CopyOfPhotoApp.SignupViewDelegateProtocol) {
        //
    }
    
    func processUserSignup(formModel: CopyOfPhotoApp.SignupFormModel) {
        processUserSignupCalled = true
    }
    
}
