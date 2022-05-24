//
//  Customer.swift
//  Shopinist
//
//  Created by Youssef on 5/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Customer
struct Customer: Codable {
    var id: Int?
    var email: String?
    var firstName, lastName: String?
    var ordersCount: Int?
    var totalSpent: String?
    var verifiedEmail: Bool?
    var phone: String?
    var tags: String?
    var addresses: [Address]?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case ordersCount = "orders_count"
        case totalSpent = "total_spent"
        case verifiedEmail = "verified_email"
        case phone, tags
        case addresses
    }
}

