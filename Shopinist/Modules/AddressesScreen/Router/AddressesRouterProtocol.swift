//
//  AddressesRouterProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/17/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol AddressesRouterProtocol {
    
    var viewController: AddressesViewController? {get set}

    func navigateToCheckout(address: Address, order: inout Order)
}
