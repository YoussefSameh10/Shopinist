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

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, values
    }
}
