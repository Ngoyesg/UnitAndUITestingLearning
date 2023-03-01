//
//  CopyOfPhotoAppUITests.swift
//  CopyOfPhotoAppUITests
//
//  Created by Natalia Goyes on 27/02/23.
//

import XCTest

final class SignupFlowUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var firstName: XCUIElement!
    private var lastName: XCUIElement!
    private var email: XCUIElement!
    private var password: XCUIElement!
    private var repeatPassword: XCUIElement!
    private var signupButton: XCUIElement!
    private var nextViewButton: XCUIElement!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launchArguments = ["-skipSurvey", "-debugServer"]
//        app.launchEnvironment = ["signupUrl": "http://appsdeveloperblog.com/api/v2/signup-mock-service-users",
//                                 "inAppPurchasesEnabled": "true",
//                                 "inAppAdsEnabled": "true"]
        app.launch()
        
        
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatPassword = app.secureTextFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]
        nextViewButton = app.buttons["nextViewButton"]
        
        continueAfterFailure = false
        
  }

    override func tearDownWithError() throws {
        app = nil
        firstName = nil
        lastName = nil
        email = nil
        password = nil
        repeatPassword = nil
        signupButton = nil
        nextViewButton = nil
        try super.tearDownWithError()
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {
        
        XCTAssertTrue(firstName.isEnabled, "firstName UITextField is not enabled for user interactions")
        XCTAssertTrue(lastName.isEnabled, "lastName UITextField is not enabled for user interactions")
        XCTAssertTrue(email.isEnabled, "email UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "password UITextField is not enabled for user interactions")
        XCTAssertTrue(repeatPassword.isEnabled, "securePassword UITextField is not enabled for user interactions")
        XCTAssertTrue(signupButton.isEnabled, "signupButton UITextField is not enabled for user interactions")
        XCTAssertTrue(nextViewButton.isEnabled, "nextViewButton UITextField is not enabled for user interactions")
    }
    
    
    func testSignupViewController_WhenInvalidFormSubmitted_PresentsErrorAlertDialog() {
        // Arrange
       
        firstName.tap()
        firstName.typeText("F")
        
        lastName.tap()
        lastName.typeText("L")
        
        email.tap()
        email.typeText("any invalid email")
        
        UIPasteboard.general.string = "123456"
        password.tap()

        password.doubleTap()
        app.menuItems["Paste"].tap()
        
        UIPasteboard.general.string = "mypassword11"
        repeatPassword.tap()
        
        // Act
        signupButton.tap()
        /*
        let emailScreenshot = email.screenshot()
        let emailAttachments = XCTAttachment(screenshot: emailScreenshot)
        emailAttachments.name = "Screenshot of email text field"
        emailAttachments.lifetime = .keepAlways
        add(emailAttachments)
        */
        // Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1.0), "An errorAlertDialog was not presented")
    }
    
    func testSignupViewController_WhenValidFormSubmitted_PresentsSuccessAlertDialog() {
        // Arrange
       
        firstName.tap()
        firstName.typeText("Sergey")
        
        lastName.tap()
        lastName.typeText("Kargopolov")
        
        email.tap()
        email.typeText("test@test.com")
        
        UIPasteboard.general.string = "mypassword"
        password.tap()

        password.doubleTap()
        app.menuItems["Paste"].tap()
        
        UIPasteboard.general.string = "mypassword"
        repeatPassword.tap()

        repeatPassword.doubleTap()
        app.menuItems["Paste"].tap()
        
        // Act
        signupButton.tap()
        
        // Assert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 3.0), "A successAlertDialog was not presented")
    }
    
    func testSignupViewController_WhenNextViewButtonTapped_PresentsSecondViewController(){
        nextViewButton.tap()
        XCTAssertTrue(app.otherElements["SecondViewController"].waitForExistence(timeout: 2.0), "The second view was not presented when next view button was tapped")
    }
    
}
