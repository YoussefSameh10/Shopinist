//
//  MainCategoriesRouter.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class MainCategoriesRouter: MainCategoriesRouterProtocol {
    weak var viewController: MainCategoriesViewController?
    

    
    func navigateToCategoriesScreen(appDelegate: AppDelegate, products: [Product], category: ProductCategory) {
        let categoriesVC = CategoriesViewController(
            nibName: "CategoriesViewController",
            viewModel: CategoriesViewModel(
                productRepo: ProductsRepo.getInstance(networkManager: NetworkManager.getInstance(), databseManager: DatabaseManager.getInstance(appDelegate: appDelegate)),
                products: products,
                category: category
            )
        )
        
        viewController?.navigationController?.pushViewController(categoriesVC, animated: true)
    }
}
