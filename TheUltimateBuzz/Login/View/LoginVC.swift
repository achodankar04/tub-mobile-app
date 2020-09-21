//
//  ViewController.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 29/07/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var textFieldEmailAddress: BuzzTextField!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var textFieldPassword: BuzzTextField!
    @IBOutlet weak var forgotPasscodeButton: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    var loginViewModelObj = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialiseEmailTextField()
        initialisePasswordTextField()
        ButtonUtility.shared.setButtonDisable(button: btnLogin)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func initialiseEmailTextField(){
        textFieldEmailAddress.delegate = self
        textFieldEmailAddress.setText(inputText: "", placeholderText: "Email Address", animated: true)
        textFieldEmailAddress.setKeyboardType(type: .emailAddress)
        textFieldEmailAddress.textFieldCustom.accessibilityIdentifier = "textfield_email"
    }
    
    fileprivate func initialisePasswordTextField(){
        textFieldPassword.delegate = self
        textFieldPassword.setText(inputText: "", placeholderText: "Password", animated: true)
        textFieldPassword.hideRightButton = false
        textFieldPassword.secureText(isSecure: true)
        textFieldPassword.setKeyboardType(type: .default)
        textFieldPassword.addRightButton(imageName: "hideText")
        textFieldPassword.textFieldCustom.accessibilityIdentifier = "textfield_password"
        textFieldPassword.rightButton.isSelected = true
    }
    
    func addTapGesture (){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        loginViewModelObj.savedLogedInUser(email: textFieldEmailAddress.value())
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forGotPasswordBtnClicked(_ sender: Any) {
    }
    
    fileprivate func changeButtonStateOnValidation(_ isValidated: Bool) {
        if isValidated
        {
            ButtonUtility.shared.setButtonEnable(button: btnLogin)
            print("validated")
        }
        else
        {
            ButtonUtility.shared.setButtonDisable(button: btnLogin)
            print("notValidated")
        }
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginVC : BUZZTextFieldDelegate{
    func rightButtonClickAction(_ textField: BuzzTextField) {
        if textField == textFieldPassword {
                if textFieldPassword.hideText {
                    textFieldPassword.secureText(isSecure: true)
                    textFieldPassword.addRightButton(imageName: "hideText")
                    textFieldPassword.rightButton.isSelected = true
                }
                else {
                    textFieldPassword.secureText(isSecure: false)
                    textFieldPassword.addRightButton(imageName: "showText")
                    textFieldPassword.rightButton.isSelected = false
                }
            }
        }
    
    func buzzTextFieldDidBeginEditing(_ textField: BuzzTextField) {
        if textField == textFieldEmailAddress{
            textFieldEmailAddress.setKeyboardReturnText(type: .next)
        }else{
            textFieldPassword.setKeyboardReturnText(type: .default)
        }
    }
    
    func buzzTextFieldShouldReturn(_ textField: BuzzTextField) -> Bool {
        if textField == textFieldEmailAddress
        {
            textFieldPassword.becomeFirstResponder()
        }
        else
        {
            textField.resignKeyboard()
        }
        return true
    }
    
    func buzzTextFieldDidEndEditing(_ textField: BuzzTextField) {
        if textField == textFieldEmailAddress {
            getEmailValidation()
        }
        textFieldPassword.secureText(isSecure: true)
        getLoginButtonState()
    }
    
    func getLoginButtonState(){
        let isValidated : Bool?
        isValidated = validateLoginCredentials(emailAddress: textFieldEmailAddress.value(), password: textFieldPassword.value())
        changeButtonStateOnValidation(isValidated!)
    }
    
    func getEmailValidation (){
        let isValidEmail = isEmailValid(email: textFieldEmailAddress.value())
        
        if !isValidEmail {
            textFieldEmailAddress.showErrorOnTextField(showError: true, hideRightButton: false, withMessage: "Please enter valid email address.", rightImageName: "textFieldError")
        }
        else {
            textFieldEmailAddress.showErrorOnTextField(showError: false, hideRightButton: false, withMessage: "", rightImageName: "textFieldValidated")
            
        }
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailReg = EmailRegExStrings.emailRegex
        let validEmail = RegexValidator.sharedInstance.validateWithRegex(regex: emailReg, for: email)
        return validEmail
    }
    
    func validateLoginCredentials( emailAddress : String, password : String) -> Bool {
        let isValidEmail = isEmailValid(email: emailAddress)
        let isValidPassword = isPasswordValid(password: password)
        return (isValidEmail && isValidPassword) ? true : false
    }
    
    func isPasswordValid(password: String) -> Bool {
        return RegexValidator.sharedInstance.validatePassword(password: password, with: 8)
    }
}

//2 photo, cheque book, pan card, aadhar card, 15K cash
