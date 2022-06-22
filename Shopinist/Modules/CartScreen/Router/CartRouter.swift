//
//  CartRouter.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/8/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import UIKit

class CartRouter: CartRouterProtocol {
    weak var viewController: CartViewController?
    
    func navigateToCheckout(order: Order) {
        //TODO:- Your view controller
        let addressesVC = AddressesViewController(addressesViewModel: AddressesViewModel(order: order))
        
        viewController?.navigationController?.pushViewController(addressesVC, animated: true)
    }
}
