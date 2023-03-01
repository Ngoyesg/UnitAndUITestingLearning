//
//  MockSignupViewDelegate.swift
//  CopyOfPhotoAppTests
//
//  Created by Natalia Goyes on 23/02/23.
//

import XCTest
@testable import CopyOfPhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    
    var expectation: XCTestExpectation?
    
    var successfulSignupCounter = 0
    
    var errorHandlerCounter = 0

    var signupError: SignupError?
    
    
    func successfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        signupError = error
        errorHandlerCounter += 1
        expectation?.fulfill()
    }
    
}
