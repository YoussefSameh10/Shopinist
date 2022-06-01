//
//  MainCategoriesRouterProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol MainCategoriesRouterProtocol {
    var viewController: MainCategoriesViewController? {get set}

    func navigateToCategoriesScreen(appDelegate: AppDelegate, products: [Product], category: ProductCategory)
}
