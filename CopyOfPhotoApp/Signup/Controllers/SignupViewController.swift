//
//  SignupViewController.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 23/02/23.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var repeatedPasswordTextField: UITextField!
    
    @IBOutlet weak var nextViewButton: UIButton!
    
    var signupPresenter: SignupPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        #if DEBUG
//        if CommandLine.arguments.contains("-skipSurvey") {
//            print("skipping survey page")
//        }
//        #endif
//
//        #if DEBUG
//        if ProcessInfo.processInfo.arguments.contains("-skipSurvey") {
//            print("skipping survey page")
//        }
//        #endif
        
        
        if signupPresenter == nil {
            
            let signupFormModelValidator = SignupFormValidator()
            
            let signupUrl = ProcessInfo.processInfo.environment["signupUrl"] ?? SignupConstants.signupURL
            
            let webService = SignupWebService(urlString: signupUrl)
            
            signupPresenter = SignupPresenter(formModelValidator: signupFormModelValidator, webService: webService, delegate: self)
            
        }
        
    }
    
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        let signupFormModel = SignupFormModel(firstName: firstNameTextField.text ?? "",
                                              lastName: lastNameTextField.text ?? "",
                                              email: emailTextField.text ?? "",
                                              password: passwordTextField.text ?? "",
                                              repeatPassword: repeatedPasswordTextField.text ?? "")
        
        signupPresenter?.processUserSignup(formModel: signupFormModel)
    }
    
    
    @IBAction func onNextViewButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier:"SecondViewController") as! SecondViewController
        secondViewController.view.accessibilityIdentifier = "SecondViewController"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}

extension SignupViewController: SignupViewDelegateProtocol {
    
    func successfulSignup() {
        let alert = UIAlertController(title: "Succes", message: "The signup operation was successful", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alert, animated: true)
        }
    }
    
    func errorHandler(error: SignupError) {
        let alert = UIAlertController(title: "error", message: "your request could not be processed at this time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true)
        }
    }
    
    
    
    
}
