//
//  RegisterViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Combine

class RegisterViewController: UIViewController {
    
    var viewModel: RegisterViewModelProtocol?
    var router: RegisterRouterProtocol?
    
    var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var addressTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    init(
        nibName: String?,
        viewModel: RegisterViewModelProtocol = RegisterViewModel(),
        router: RegisterRouterProtocol = RegisterRouter()
    ) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router?.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
        setupButtons()
        listenForResponse()
    }
    
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupButtons() {
        signupButton.layer.cornerRadius = 25
        signinButton.titleLabel?.textAlignment = .center
        invalidateButton()
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
        viewModel?.registerCustomer(
            name: nameTextField.text!,
            email: emailTextField.text!,
            password: passwordTextField.text!,
            address: addressTextField.text!
        )
        
        
    }
    
    @IBAction func navigateToLogin(_ sender: Any) {
        router?.navigateToLogin()
    }
    
    @IBAction func textFieldDidChange(_ sender: SkyFloatingLabelTextField) {
        validateTextFields()
    }
    
    private func validateTextFields() {
        if !(nameTextField.text?.isEmpty ?? false)
            && !(emailTextField.text?.isEmpty ?? false)
            && !(addressTextField.text?.isEmpty ?? false)
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
    
    private func listenForResponse() {
        viewModel?.validEmail
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { (completion) in
                    switch completion {
                        case .finished:
                            print("Finished")
                        case .failure:
                            print("Failed")
                    }
                },
                receiveValue: { (response) in
                    guard let response = response else {
                        return
                    }
                    if response == true {
                        self.router?.navigateToHome()
                    }
                    else {
                        self.showErrorAlert()
                    }
                }
            ).store(in: &cancellables)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "This email is already used.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
