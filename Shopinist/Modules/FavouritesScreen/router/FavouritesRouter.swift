//
//  FavouritesRouter.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class FavouritesRouter : FavouritesRouterProtocol {
    
    var viewController: FavouritesViewController?
    
    func navigateToProductDetailsScreen(appDelegate: AppDelegate, product: Product) {
        
        let productDetailsVC = ProductDetailsViewController(
            nibName: "ProductDetailsViewController",
            viewModel: ProductDetailsViewModel(
                product:product,
                productRepo: FavouritesProductRepo.getInstance(databaseManager: FavouritesDataBaseManager.getInstance(appDelegate: appDelegate)), cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: appDelegate))
            )
        )
        viewController?.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    
    func navigateToRegisterScreen(){
        
        let regitserVC = RegisterViewController(nibName: "RegisterViewController", viewModel: RegisterViewModel(repo: CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())), router: RegisterRouter())
        
        viewController?.navigationController?.pushViewController(regitserVC, animated: true)
        
    }
    
    
}
