//
//  SignupPresenterTests.swift
//  CopyOfPhotoAppTests
//
//  Created by Natalia Goyes on 23/02/23.
//

import XCTest
@testable import CopyOfPhotoApp

final class SignupPresenterTests: XCTestCase {
    
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidator: MockSignupModelValidator!
    var mockSignupWebService: MockSignupWebSevice!
    var mockSignupViewDelegate: MockSignupViewDelegate!
    var sut: SignupPresenter!
    
    override func setUp()  {
        super.setUp()
        
        signupFormModel = SignupFormModel(
            firstName: "Natalia",
            lastName: "Andrzejewski",
            email: "test@test.com",
            password: "12345678",
            repeatPassword: "12345678")
        
        mockSignupModelValidator = MockSignupModelValidator()
        
        mockSignupWebService = MockSignupWebSevice()
        
        mockSignupViewDelegate = MockSignupViewDelegate()

        
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator,
                              webService: mockSignupWebService,
                              delegate: mockSignupViewDelegate)
    }
    
    override func tearDown()  {
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
        sut = nil
        super.tearDown()
    }
    
    func testSignupPresenter_WhenInformationProivded_WillValidateEachProperty() {
                
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailValidated, "Email was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "Matching between password and repeated password was not validated")
    }

    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod(){
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The signup() method was not called i the SignupWebService class")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_ShouldCallSuccessOnViewDelegate(){
        
        // Act
        let successfulExpectation = expectation(description: "Expected the successfulSignup() method to be called")
        
        mockSignupViewDelegate.expectation = successfulExpectation
       
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [successfulExpectation], timeout: 5)

        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "The successfulSignup() method was called more than once")
    }
    
    func testSignupPresenter_WhenSignupOperationFailed_ShouldCallErrorViewDelegate(){
        
        // Act
        let errorHandlerExpectation = expectation(description: "Expected the errorHandler() method to be called")
        mockSignupViewDelegate.expectation = errorHandlerExpectation
        mockSignupWebService.shouldReturnError = true
       
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [errorHandlerExpectation], timeout: 5)

        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0, "The successfulSignup() method should not be called")
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerCounter, 1, "The errorHandler() method was called more than once")
        XCTAssertNotNil(mockSignupViewDelegate.signupError, "SignupError should not be nil")
    }
    
    
}
