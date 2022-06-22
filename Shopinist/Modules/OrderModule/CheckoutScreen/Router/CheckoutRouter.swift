//
//  CheckoutRouter.swift
//  Shopinist
//
//  Created by Youssef on 6/7/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class CheckoutRouter: CheckoutRouterProtocol {
    
    var viewController: CheckoutViewController?
    
    func navigateToOrderCompletedScreen() {
        let completedOrderVC = CompletedOrderViewController()
        viewController?.navigationController?.pushViewController(completedOrderVC, animated: true)
    }
}
