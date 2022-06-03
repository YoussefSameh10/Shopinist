//
//  LoginRouterProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol LoginRouterProtocol {
    var viewController: LoginViewController? {get set}
    
    func navigateToRegister()
    func navigateToHome()
}
