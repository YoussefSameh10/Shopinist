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
        let registerVC = RegisterViewController(nibName: "RegisterViewController")
        guard var viewControllers = viewController?.navigationController?.viewControllers else { return }
        _ = viewControllers.popLast()
        viewControllers.append(registerVC)
        viewController?.navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    
}
