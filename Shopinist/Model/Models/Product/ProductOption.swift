//
//  ProductOption.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Option
struct ProductOption: Codable {
    
    var id, productID: Int?
    var name: ProductOptionName?
    var values: [String]?

    init(){}
    
    init(name : ProductOptionName , values : [String]){
        self.name = name
        self.values = values
    }
    
    init(id: Int? = nil, productID: Int? = nil, name: ProductOptionName? = nil, values: [String]? = nil) {
        self.id = id
        self.productID = productID
        self.name = name
        self.values = values
    }

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, values
    }
}
