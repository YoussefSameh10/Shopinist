//
//  AddressesRouter.swift
//  Shopinist
//
//  Created by Youssef on 6/17/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import UIKit

class AddressesRouter: AddressesRouterProtocol {
    
    weak var viewController: AddressesViewController?
    
    func navigateToCheckout(address: Address, order: inout Order) {
        order.shippingAddress = address
        let checkoutVC = CheckoutViewController(
            viewModel: CheckoutViewModel(
                cartItemsManager: CartItemsManager.getInstance(
                    appDelegate: UIApplication.shared.delegate as! AppDelegate
                ),
                order: order
            )
        )
        viewController?.navigationController?.pushViewController(checkoutVC, animated: true)
    }
}
