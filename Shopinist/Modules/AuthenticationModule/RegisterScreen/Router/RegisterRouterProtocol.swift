//
//  RegisterRouterProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol RegisterRouterProtocol {
    var viewController: RegisterViewController? {get set}
    
    func navigateToHome()
    func navigateToLogin()
}
