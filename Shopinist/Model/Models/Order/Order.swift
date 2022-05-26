//
//  Order.swift
//  Shopinist
//
//  Created by Youssef on 5/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Order
struct Order: Codable {
    var id: Int?
    var customer: Customer?
    var orderItems: [OrderItem]?
    var cancelReason: String?
    var currentTotalPrice: String?
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var discountCodes: [DiscountCode]?
    var financialStatus: OrderFinancialStatus?
    var fulfillmentStatus: String?
    var totalDiscounts: String?
    var totalPrice: String?
    

    enum CodingKeys: String, CodingKey {
        case id
        case customer
        case orderItems = "line_items"
        case cancelReason = "cancel_reason"
        case currentTotalPrice = "current_total_price"
        case discountCodes = "discount_codes"
        case financialStatus = "financial_status"
        case fulfillmentStatus = "fulfillment_status"
        case totalDiscounts = "total_discounts"
        case totalPrice = "total_price"
    }
    
    init(customer: Customer, orderItems: [OrderItem]) {
        self.customer = customer
        self.orderItems = orderItems
    }
}

