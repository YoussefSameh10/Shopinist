//
//  SearchFilter.swift
//  Shopinist
//
//  Created by Youssef on 6/4/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class SearchFilter: Filter {
    var filterDecorator: FilterProductsDecorator
    var searchString: String
    
    init(filterDecorator: FilterProductsDecorator, searchString: String) {
        self.filterDecorator = filterDecorator
        self.searchString = searchString
    }
    
    func getProducts() -> [Product] {
        let products = filterDecorator.getProducts()
        if searchString.isEmpty {
            return products
        }
        var filteredProducts: [Product] = []
        
        for product in products {
            if product.title?.lowercased().contains(searchString.lowercased()) ?? true {
                filteredProducts.append(product)
            }
        }
        return filteredProducts
    }
    
    
}
