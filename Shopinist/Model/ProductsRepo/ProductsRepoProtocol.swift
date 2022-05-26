//
//  ProductsRepoProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 26/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

protocol ProductsRepoProtocol {
    
    func getAllProducts() -> Future<Products,Error>
    func getAllProductsOfCategory(category : ProductCategory) -> Future<Products,Error>
    
}
