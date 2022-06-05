//
//  CategoriesFilterViewModelProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/4/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol CategoriesFilterViewModelProtocol {
    var filterType: FilterType {get set}
    var filterDirection: FilterDirection {get set}
    var maxPrice: Int {get set}
    
    func filterProducts()
    
}
