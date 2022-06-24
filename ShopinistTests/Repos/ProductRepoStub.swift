//
//  ProductRepoStub.swift
//  ShopinistTests
//
//  Created by Youssef on 6/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine
@testable import Shopinist

class ProductRepoStub: ProductsRepoProtocol {
    func getAllProducts() -> Future<Products, Error> {
        return Future { promise in
            promise(.success(Products(products: [Product()])))
        }
    }
    
    func getAllProductsOfCategory(category: ProductCategory) -> Future<Products, Error> {
        return Future { promise in
            promise(.success(Products(products: [])))
        }
    }
    
    
}
