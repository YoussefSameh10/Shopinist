//
//  BrandFilter.swift
//  Shopinist
//
//  Created by Youssef on 6/5/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class BrandFilter: Filter {
    
    var filterDecorator: FilterProductsDecorator
    var brandName: String?
    
    init(filterDecorator: FilterProductsDecorator, brandName: String?) {
        self.filterDecorator = filterDecorator
        self.brandName = brandName
    }
    
    func getProducts() -> [Product] {
        let products = filterDecorator.getProducts()
        if brandName == nil {
            return products
        }
        var filteredProducts: [Product] = []
        
        for product in products {
            if product.vendor == brandName {
                filteredProducts.append(product)
            }
        }
        return filteredProducts
    }
}
