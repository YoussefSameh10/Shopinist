//
//  Products.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Products
class Products: Codable {
    
    var products: [Product]?

    init(products: [Product]?) {
        self.products = products
    }
}




