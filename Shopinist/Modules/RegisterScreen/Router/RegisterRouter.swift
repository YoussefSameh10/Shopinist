//
//  RegisterRouter.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class RegisterRouter: RegisterRouterProtocol {
    weak var viewController: RegisterViewController?
    
    func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToLogin() {
        let loginVC = LoginViewController(
            nibName: "LoginViewController",
            viewModel: LoginViewModel(
                repo: CustomerRepo.getInstance(
                    networkManager: NetworkManager.getInstance()
                )
            ),
            router: LoginRouter()
        )
        viewController?.navigationController?.popViewController(animated: true)
        
        viewController?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}
