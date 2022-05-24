//
//  DiscountCode.swift
//  Shopinist
//
//  Created by Youssef on 5/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - DiscountCode
struct DiscountCode: Codable {
    var id, priceRuleID: Int?
    var code: String?
    var usageCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case priceRuleID = "price_rule_id"
        case code
        case usageCount = "usage_count"
    }
}

