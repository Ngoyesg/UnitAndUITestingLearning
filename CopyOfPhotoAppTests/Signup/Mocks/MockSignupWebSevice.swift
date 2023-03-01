//
//  MockSignupWebSevice.swift
//  CopyOfPhotoAppTests
//
//  Created by Natalia Goyes on 23/02/23.
//

import Foundation
@testable import CopyOfPhotoApp

class MockSignupWebSevice: SignupWebServiceProtocol {
    
    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false
    
    func signup(withForm formModel: CopyOfPhotoApp.SignupFormRequestModel, completionHandler: @escaping (CopyOfPhotoApp.SignupResponseModel?, CopyOfPhotoApp.SignupError?) -> Void) {
        
        isSignupMethodCalled = true
        
        if shouldReturnError {
            completionHandler(nil, SignupError.failedRequest(description: "Signup request was not successful"))
        } else {
            let signupResponseModel = SignupResponseModel(status: "ok")
            completionHandler(signupResponseModel, nil)
        }
    }
    
}
