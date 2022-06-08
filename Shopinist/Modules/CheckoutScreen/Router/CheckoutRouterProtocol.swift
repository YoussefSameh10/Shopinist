//
//  CheckoutRouterProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/7/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol CheckoutRouterProtocol {
    var viewController: CheckoutViewController? {get set}
    
    func navigateToHome()
}

