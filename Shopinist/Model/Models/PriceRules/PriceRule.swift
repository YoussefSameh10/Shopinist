//
//  PriceRule.swift
//  Shopinist
//
//  Created by Youssef on 6/6/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - PriceRule
struct PriceRule: Codable {
    var id: Int?
    var title: String?
    var valueType, value, targetType: String?
    var usageLimit: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case valueType = "value_type"
        case value
        case targetType = "target_type"
        case usageLimit = "usage_limit"
    }
}
