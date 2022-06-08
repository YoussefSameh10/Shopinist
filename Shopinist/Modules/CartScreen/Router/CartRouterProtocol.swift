//
//  CartRouterProtocol.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/8/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol CartRouterProtocol {
    var viewController : CartViewController? {get set}
    
    func navigateToCheckout(orderItems : [OrderItem])
}
