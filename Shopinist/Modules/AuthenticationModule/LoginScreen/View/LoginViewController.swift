//
//  LoginViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import NVActivityIndicatorView
import Combine

class LoginViewController: BaseViewController {
    
    // MARK: -Variables
    private var viewModel: LoginViewModelProtocol!
    private var router: LoginRouterProtocol!
    private var cancellables: Set<AnyCancellable> = []
    var indicator: NVActivityIndicatorView!
    
    
    // MARK: -Outlets
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    // MARK: -Initializers
    init(
        nibName: String?,
        viewModel: LoginViewModelProtocol = LoginViewModel(),
        router: LoginRouterProtocol = LoginRouter()
    ) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBars()
        setupSigninButton()
        listenForResponse()
    }
    
    // MARK: -Methods
    private func hideBars() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupSigninButton() {
        signinButton.layer.cornerRadius = 25
        signupButton.titleLabel?.textAlignment = .center
        invalidateButton()
    }
    
    private func listenForResponse() {
        viewModel.isValidLogin.sink(
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
                self.stopActivityIndicator()
                if response {
                    self.router.navigateToHome()
                }
                else {
                    self.showErrorAlert()
                }
            }
        ).store(in: &cancellables)
    }

    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Couldn't log in. Please check your credentials", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

    
    // MARK: -Actions
    @IBAction func textFieldDidChange(_ sender: Any) {
        validateTextFields()
    }
    
    @IBAction func signin(_ sender: Any) {
        startActivityIndicator()
        viewModel.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    @IBAction func navigateToRegister(_ sender: Any) {
        router.navigateToRegister()
    }
    @IBAction func continueAsGuest(_ sender: Any) {
        router.navigateToHome()
    }
}

extension LoginViewController {
    private func startActivityIndicator() {
        indicator = createActivityIndicator()
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        indicator.stopAnimating()
    }
}
