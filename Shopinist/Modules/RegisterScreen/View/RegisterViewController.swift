//
//  RegisterViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var addressTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
        setupButtons()
        setupTextFields()
    }
    
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupButtons() {
        signupButton.layer.cornerRadius = 25
        
        invalidateButton()
    }
    
    
    
    private func setupTextFields() {
        let textFields = [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField, addressTextField, phoneTextField]
        
        for textField in textFields {
//            textField?.layer.cornerRadius = 15
//            textField?.layer.masksToBounds = true
//            textField?.layer.borderWidth = 1
//            textField?.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        }
    }
    
    private func validateButton() {
        signupButton.isEnabled = true
        signupButton.backgroundColor = .black
        signupButton.layer.borderWidth = 0
        signupButton.setTitleColor(.white, for: .normal)
    }
    
    private func invalidateButton() {
        signupButton.isEnabled = false
        signupButton.backgroundColor = .clear
        signupButton.setTitleColor(.darkGray, for: .normal)
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = .init(srgbRed: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
    }
    
    @IBAction func signup(_ sender: Any) {
        print("SIGNUP")
    }
    
    @IBAction func navigateToLogin(_ sender: Any) {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func textFieldDidChange(_ sender: SkyFloatingLabelTextField) {
        validateTextFields()
    }
    
    private func validateTextFields() {
        if !(nameTextField.text?.isEmpty ?? false)
            && !(emailTextField.text?.isEmpty ?? false)
            && !(addressTextField.text?.isEmpty ?? false)
            && !(phoneTextField.text?.isEmpty ?? false)
            && validatePassword(){
            
            validateButton()
        }
        else {
            invalidateButton()
        }
        
    }
    
    private func validatePassword() -> Bool {
        if (passwordTextField.text?.count ?? 0 > 7)
            && (confirmPasswordTextField.text?.count ?? 0 > 7)
            && (passwordTextField.text == confirmPasswordTextField.text) {
            return true
        }
        else {
            return false
        }
    }
}
