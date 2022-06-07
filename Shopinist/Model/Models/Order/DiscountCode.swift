//
//  DiscountCode.swift
//  Shopinist
//
//  Created by Youssef on 5/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - DiscountCode
struct DiscountCodeOLD: Codable {
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

struct DiscountCode: Codable {
    var code: String?
    var amount: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case amount
        case type
    }
}

