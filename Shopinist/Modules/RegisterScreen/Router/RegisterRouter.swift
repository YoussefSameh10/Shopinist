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
        let loginVC = LoginViewController(nibName: "LoginViewController")
        guard var viewControllers = viewController?.navigationController?.viewControllers else { return }
        _ = viewControllers.popLast()
        viewControllers.append(loginVC)
        viewController?.navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    
}
