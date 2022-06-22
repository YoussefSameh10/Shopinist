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

    func navigateToCategoriesScreen(appDelegate: AppDelegate, category: ProductCategory, brandName: String?) {
        let categoriesVC = CategoriesViewController(
            nibName: "CategoriesViewController",
            viewModel: CategoriesViewModel(
                productRepo: ProductsRepo.getInstance(networkManager: NetworkManager.getInstance(), databseManager: DatabaseManager.getInstance(appDelegate: appDelegate)),
                category: category,
                brandName: brandName
            )
        )
        viewController?.navigationController?.pushViewController(categoriesVC, animated: true)
    }
}
