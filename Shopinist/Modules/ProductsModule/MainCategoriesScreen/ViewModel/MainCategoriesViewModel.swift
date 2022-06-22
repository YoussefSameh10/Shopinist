//
//  MainCategoriesViewModel.swift
//  Shopinist
//
//  Created by Youssef on 5/31/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class MainCategoriesViewModel: MainCategoriesViewModelProtocol {
        
    var brandName: String?
    var category: ProductCategory?
    let titles = [
        "men",
        "women",
        "kids",
        "sales"
    ]
    
    init(brandName: String? = nil) {
        self.brandName = brandName
    }
}
