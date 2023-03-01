//
//  SignupViewControllerTests.swift
//  CopyOfPhotoAppTests
//
//  Created by Natalia Goyes on 23/02/23.
//

import XCTest
@testable import CopyOfPhotoApp

final class SignupViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: SignupViewController!
    var navigationController: UINavigationController!
    
    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController
        sut.loadViewIfNeeded()
        navigationController = UINavigationController(rootViewController: sut)
    }
    
    override  func tearDown() {
        storyboard = nil
        sut = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        
        //assert
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firtNameTextField is not connected to an IBOutlet")
        
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastNameTextField is not connected to an IBOutlet")
        
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The emailTextField is not connected to an IBOutlet")
        
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The passwordTextField is not connected to an IBOutlet")
        
        let repeatedPasswordTextField = try XCTUnwrap(sut.repeatedPasswordTextField, "The repeatedPasswordTextField is not connected to an IBOutlet")
        
        XCTAssertEqual(firstNameTextField.text, "", "firtNameTextField should have been empty when viewController initially loaded")
        XCTAssertEqual(lastNameTextField.text, "", "lastNameTextField should have been empty when viewController initially loaded")
        XCTAssertEqual(emailTextField.text, "", "emailTextField should have been empty when viewController initially loaded")
        XCTAssertEqual(passwordTextField.text, "", "passwordTextField should have been empty when viewController initially loaded")
        XCTAssertEqual(repeatedPasswordTextField.text, "", "repeatedPasswordTextField should have been empty when viewController initially loaded")
    }
    
    func testSignupViewController_WhenCreated_HasSignupButtonAndAction() throws {
        
        // Arrange
        
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "SignupButton does not have a referencing outlet")
        
        // Act
        
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "The signupButton has no actions assigned to it")
        
        // Assert
        
        XCTAssertEqual(signupButtonActions.count, 1, "The number of actions of the signupButton should have been 1")
        
        XCTAssertEqual(signupButtonActions.first, "signupButtonTapped:", "There is no method signupButtonTapped in the signupButton actions")
        
    }
    
    
    func testSignupViewController_WhenSignupButtonTapped_InvokeSignupPRocess(){
        
        // Arrange
        
        let mockSignupFormModelValidator = MockSignupModelValidator()
        
        let mockSignupWebService = MockSignupWebSevice()
        
        let mockSignupViewDelegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupFormModelValidator, webService: mockSignupWebService, delegate: mockSignupViewDelegate)
        
        sut.signupPresenter = mockSignupPresenter
        
        // Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled, "The processIserSignup() method was not called on a Presenter object when the signupButton was tapped in ta SignupViewController")
    }
    
    func testSignupViewController_WhenCreated_HasEmailAdressContentTypeSets() throws {
        
        let emailTextField = try XCTUnwrap(sut.emailTextField, "There was no text field connected")
        
        XCTAssertEqual(emailTextField.textContentType, .emailAddress, "The emailAddressTextField does not have a content type set as Email Address")
    }

    func testSignupViewController_WhenCreated_HasEmailKeyboardTypeSet() throws {
        
        let emailTextField = try XCTUnwrap(sut.emailTextField, "There was no text field connected")
        
        XCTAssertEqual(emailTextField.keyboardType, .emailAddress, "The emailAddressTextField does not have a keyboard type set as Email Address")
    }
    
    func testSignupViewController_WhenCreated_HasPasswordSecureTextEntry() throws {
        
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "There was no text field connected")
        
        XCTAssertTrue(passwordTextField.isSecureTextEntry, "The passwordTextField is not a secure text entry field")
    }
    
    func testSignupViewController_WhenNextViewButtonTapped_SecondViewControllerIsPushed_V1() {
        
        let myPredicate = NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is SecondViewController
        }
        
        expectation(for: myPredicate, evaluatedWith: navigationController)
        
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 1.5)
        
    }
    
    func testSignupViewController_WhenNextViewButtonTapped_SecondViewControllerIsPushed_V2() {
        
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        RunLoop.current.run(until: Date())
        
        guard let _ = navigationController.topViewController as? SecondViewController else {
            XCTFail()
            return
        }
    }
    
    func testSignupViewController_WhenNextViewButtonTapped_SecondViewControllerIsPushed_V3() {
        
        let spyNavigationController = SPyNavigationController(rootViewController: sut)
        
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        guard let _ = spyNavigationController.pushedViewController as? SecondViewController else {
            XCTFail()
            return
        }
    }
    
}

