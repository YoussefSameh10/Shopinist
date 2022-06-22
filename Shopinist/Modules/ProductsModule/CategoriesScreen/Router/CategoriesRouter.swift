//
//  CategoriesRouter.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class CategoriesRouter: CategoriesRouterProtocol {
    
    weak var viewController: CategoriesViewController?
    
    func navigateToProductDetailsScreen(appDelegate: AppDelegate, product: Product) {
        let productDetailsVC = ProductDetailsViewController(
            nibName: "ProductDetailsViewController",
            viewModel: ProductDetailsViewModel(
                product: product,
                productRepo: FavouritesProductRepo.getInstance(databaseManager: FavouritesDataBaseManager.getInstance(appDelegate: appDelegate)), cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: appDelegate))
            )
        )
        
        
        viewController?.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func navigateToFilterScreen(viewModel: CategoriesFilterViewModelProtocol) {
        let filterVC = FilterAlertViewController(nibName: "FilterAlertViewController", viewModel: viewModel)
        viewController?.navigationController?.present(filterVC, animated: true, completion: nil)
    }
    
    
}
