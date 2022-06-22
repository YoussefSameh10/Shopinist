//
//  ProductsContainer.swift
//  Shopinist
//
//  Created by Youssef on 6/4/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class ProductsContainer: FilterProductsDecorator {
    
    let products: [Product]
    
    init(products: [Product]) {
        self.products = products
    }
    
    func getProducts() -> [Product] {
        return products
    }
    
    
}
