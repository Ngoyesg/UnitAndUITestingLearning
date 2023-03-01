//
//  SignupFormValidatorTests.swift
//  CopyOfPhotoAppTests
//
//  Created by Natalia Goyes on 21/02/23.
//

import XCTest
@testable import CopyOfPhotoApp

final class SignupFormValidatorTests: XCTestCase {

    var sut: SignupFormValidator!
    
    override func setUp() {
        super.setUp()
        sut = SignupFormValidator()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSignupFormModelValidator_WhenValidNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isNameValid = sut.isNameValid("Natalia")
        
        // Assert
        XCTAssertTrue(isNameValid, "The isNameValid() method should have returned TRUE for a valid first name, but returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenTooShortNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isNameValid = sut.isNameValid("n")
        
        // Assert
        XCTAssertFalse(isNameValid, "The isNameValid() method should have returned FALSE for a name shorter than 2 characters, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isNameValid = sut.isNameValid("NataliaNataliaNataliaNataliaNatalia")
        
        // Assert
        XCTAssertFalse(isNameValid, "The isNameValid() method should have returned FALSE for a name longer than 10 characters, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid("Andrzejewski")
        
        // Assert
        XCTAssertTrue(isLastNameValid, "The isLastNameValid() method should have returned TRUE for a valid first name, but returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid("n")
        
        // Assert
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() method should have returned FALSE for a name shorter than 2 characters, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid("AndrzejewskiAndrzejewskiAndrzejewskiAndrzejewski")
        
        // Assert
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() method should have returned FALSE for a name longer than 10 characters, but returned TRUE")
    }
    
    
    
    
    func testSignupFormModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isEmailValid = sut.isEmailValid("test@test.edu")
        
        // Assert
        XCTAssertTrue(isEmailValid, "The isEmailValid() method should have returned TRUE for a valid first name, but returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenTooShortEmailProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isEmailValid = sut.isEmailValid("t@h.")
        
        // Assert
        XCTAssertFalse(isEmailValid, "The isEmailValid() method should have returned FALSE for an email shorter than 5 characters, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongEmailProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isEmailValid = sut.isEmailValid("testtesttest@testtesttesttest.com")
        
        // Assert
        XCTAssertFalse(isEmailValid, "The isEmailValid() method should have returned FALSE for an email longer than 30 characters, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid("password123")
        
        // Assert
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() method should have returned TRUE for a valid password, but returned FALSE")
    }
    
    
    func testSignupFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid("123")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() method should have returned FALSE for a short password, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid("passwordpasswordpasswordpasswordpassword")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() method should have returned FALSE for a long password, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenEqualPasswordsProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch("password123", "password123")
        
        // Assert
        XCTAssertTrue(doPasswordsMatch, "The doPasswordsMatch() method should have returned TRUE for repeated password is equal to password, but returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenNotMatchingPasswordsProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch("password123", "1234567")
        
        // Assert
        XCTAssertFalse(doPasswordsMatch, "The doPasswordsMatch() method should have returned FALSE for repeated password NOT matching a password, but returned TRUE")
    }
}
