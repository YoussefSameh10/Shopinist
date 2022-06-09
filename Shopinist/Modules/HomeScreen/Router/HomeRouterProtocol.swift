//
//  HomeRouterProtocol.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/9/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol HomeRouterProtocol {
    var viewController : HomeViewController? {get set}
    
    func navigateToMainCategoriesScreen(brandName: String)
}
