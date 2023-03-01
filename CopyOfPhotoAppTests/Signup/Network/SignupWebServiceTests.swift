//
//  SignupWebServiceTests.swift
//  CopyOfPhotoAppTests
//
//  Created by Natalia Goyes on 22/02/23.
//

import XCTest
@testable import CopyOfPhotoApp

final class SignupWebServiceTests: XCTestCase {
    
    private var sut: SignupWebService!
    private var signupFormRequestModel: SignupFormRequestModel!

    
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupURL, urlSession: urlSession)
        signupFormRequestModel = SignupFormRequestModel(firstName: "Natalia", lastName: "Andrzejewski", email: "test@test.com", password: "12345678")

    }
    
    override func tearDown() {
        sut = nil
        signupFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil // This is here because stubResponseData is static
        MockURLProtocol.error = nil
        super.tearDown()
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSuccess(){
        
        //Arrange
        
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)

        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        //Act

        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            //Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        //Arrange
        
        let jsonString = "{\"path\":\"/users\", \"error\": \"Internal server error\"}"
        
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
                
        let expectation = self.expectation(description: "signup() method expectation for a response that containis a different JSON structure")
        
        //Act

        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            //Assert
            XCTAssertNil(signupResponseModel, "The response model for a request containing unknown KSON response should have been nil")
            XCTAssertEqual(error, SignupError.invalidResponseModel, "the signup() method did not return expected error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnsError() {
        //Arrange
        
        sut = SignupWebService(urlString: "")
        let expectation = self.expectation(description: "An empty request URL string expectation")
        
        //Act
        
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            //Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "signup() method did not return expected error")
            XCTAssertNil(signupResponseModel, "When invalid request urlString takes place, the response model must be nil")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription(){
        //Arrange
        let expectation = self.expectation(description: "A failed request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)
        
        //Arrange
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            //Assert
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription), "The signup() method did not return an expected error for a failed request")
            expectation.fulfill()

        }
        self.wait(for: [expectation], timeout: 2)

    }
    
    
}
