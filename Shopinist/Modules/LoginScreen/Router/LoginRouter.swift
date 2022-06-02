//
//  LoginRouter.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class LoginRouter: LoginRouterProtocol {
    
    weak var viewController: LoginViewController?
    
    func navigateToRegister() {
        let registerVC = RegisterViewController(
            nibName: "RegisterViewController",
            viewModel: RegisterViewModel(
                repo: CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())
            ),
            router: RegisterRouter()
        )
        viewController?.navigationController?.popViewController(animated: true)
        viewController?.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func navigateToHome() {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        viewController?.navigationController?.popViewController(animated: true)
        viewController?.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    
}
