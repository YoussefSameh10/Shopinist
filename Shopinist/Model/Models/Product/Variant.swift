//
//  Variant.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Variant
struct Variant: Codable {
   
    var id, productID: Int?
    var price: String?
    var productSize: String?
    var productColor: String?
    var inventoryQuantity: Int?
    
    init(id: Int? = nil, productID: Int? = nil, price: String? = nil, productSize: String? = nil, productColor: String? = nil, inventoryQuantity: Int? = nil) {
        self.id = id
        self.productID = productID
        self.price = price
        self.productSize = productSize
        self.productColor = productColor
        self.inventoryQuantity = inventoryQuantity
    }
    
    init(){}
    
    init(price : String){
        self.price = price
    }

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case price
        case productSize, productColor
        case inventoryQuantity = "inventory_quantity"
    }
}
