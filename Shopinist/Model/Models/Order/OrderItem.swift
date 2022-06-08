//
//  LineItem.swift
//  Shopinist
//
//  Created by Youssef on 5/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - LineItem
struct OrderItem: Codable {
    var id: Int?
    var giftCard: Bool?
    var productExists: Bool?
    var productID: Int?
    var quantity: Int?
    var title, totalDiscount: String?
    var variantID: Int?
    var price : String?

    enum CodingKeys: String, CodingKey {
        case id
        case giftCard = "gift_card"
        case productExists = "product_exists"
        case productID = "product_id"
        case quantity
        case title
        case totalDiscount = "total_discount"
        case variantID = "variant_id"
        case price
    }
}
