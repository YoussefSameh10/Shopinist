//
//  CategoriesFilter.swift
//  Shopinist
//
//  Created by Youssef on 6/4/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class CategoriesFilter: Filter {
    var filterDecorator: FilterProductsDecorator
    var category: ProductType?
    
    init(filterDecorator: FilterProductsDecorator, category: ProductType?) {
        self.filterDecorator = filterDecorator
        self.category = category
    }
    
    func getProducts() -> [Product] {
        let products = filterDecorator.getProducts()
        if category == nil {
            return products
        }
        var filteredProducts: [Product] = []
        
        for product in products {
            if product.productType == category {
                filteredProducts.append(product)
            }
        }
        return filteredProducts
    }
    
    
}
