//
//  LoginViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSigninButton()
    }
    
    private func setupSigninButton() {
        signinButton.layer.cornerRadius = 25
        invalidateButton()
    }

    @IBAction func textFieldDidChange(_ sender: Any) {
        validateTextFields()
    }
    
    private func validateTextFields() {
        if !(emailTextField.text?.isEmpty ?? true)
            && passwordTextField.text?.count ?? 0 > 7 {
            
            validateButton()
        }
        else {
            invalidateButton()
        }
    }
    
    private func validateButton() {
        signinButton.isEnabled = true
        signinButton.backgroundColor = .black
        signinButton.layer.borderWidth = 0
        signinButton.setTitleColor(.white, for: .normal)
    }
    
    private func invalidateButton() {
        signinButton.isEnabled = false
        signinButton.backgroundColor = .clear
        signinButton.setTitleColor(.darkGray, for: .normal)
        signinButton.layer.borderWidth = 1
        signinButton.layer.borderColor = .init(srgbRed: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
    }

    @IBAction func signin(_ sender: Any) {
    }
    @IBAction func navigateToRegister(_ sender: Any) {
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    

}
