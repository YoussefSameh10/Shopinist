//
//  PriceFilter.swift
//  Shopinist
//
//  Created by Youssef on 6/4/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class PriceFilter: Filter {
    var filterDecorator: FilterProductsDecorator
    var price: Int
    
    init(filterDecorator: FilterProductsDecorator, price: Int) {
        self.filterDecorator = filterDecorator
        self.price = price
    }
    
    func getProducts() -> [Product] {
        let products = filterDecorator.getProducts()
        
        var filteredProducts: [Product] = []
        
        for product in products {
            if Formatter.getIntPrice(from: product.variants?[0].price ?? "0") <= price {
                filteredProducts.append(product)
            }
        }
        return filteredProducts
    }
}
