//
//  CategoriesRouterProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol CategoriesRouterProtocol {
    var viewController: CategoriesViewController? {get set}
    
    func navigateToProductDetailsScreen(appDelegate: AppDelegate, product: Product)
    func navigateToFilterScreen(viewModel: CategoriesFilterViewModelProtocol)
}
