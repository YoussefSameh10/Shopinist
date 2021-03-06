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
    var createdAt: String?
    var currency: String?
    var totalPriceUsd: String?
    var discountCodes: [DiscountCode]?
    var financialStatus: OrderFinancialStatus?
    var fulfillmentStatus: String?
    var subTotalPrice: String?
    var totalDiscounts: String?
    var totalPrice: String?
    var shippingAddress: Address?
    

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
        case totalPrice = "total_line_items_price"
        case createdAt = "created_at"
        case currency
        case totalPriceUsd = "total_price_usd"
        case subTotalPrice = "subtotal_price"
        case shippingAddress = "shipping_address"
    }
    
    init(customer: Customer, orderItems: [OrderItem]) {
        self.customer = customer
        self.orderItems = orderItems
    }
    
    init(customer: Customer, orderItems: [OrderItem], totalPrice : String) {
        self.customer = customer
        self.orderItems = orderItems
        self.totalPrice = totalPrice
    }
}

