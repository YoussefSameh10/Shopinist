//
//  PriceRules.swift
//  Shopinist
//
//  Created by Youssef on 6/6/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - PriceRules
struct PriceRules: Codable {
    var priceRules: [PriceRule]?

    enum CodingKeys: String, CodingKey {
        case priceRules = "price_rules"
    }
}


