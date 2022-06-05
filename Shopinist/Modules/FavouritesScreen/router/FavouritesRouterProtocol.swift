//
//  FavouritesRouterProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol FavouritesRouterProtocol {
    
    var viewController: FavouritesViewController? {get set}
    func navigateToProductDetailsScreen(appDelegate: AppDelegate, product: Product)
    func navigateToRegisterScreen()
    
}
