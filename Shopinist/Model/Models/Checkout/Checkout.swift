//
//  Checkout.swift
//  Shopinist
//
//  Created by Youssef on 6/6/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Checkout
struct Checkout: Codable {
    
    var currency, presentmentCurrency: String?
    var customerID: Int?
    var discountCode: DiscountCode?
    var email: String?
    var orderID: Int?
    var paymentURL: String?
    var phone: String?
    var subtotalPrice: String?
    var totalPrice: String?
    var totalLineItemsPrice: String?
    var lineItems: [OrderItem]?

    enum CodingKeys: String, CodingKey {

        case currency
        case presentmentCurrency = "presentment_currency"
        case customerID = "customer_id"
        case discountCode = "discount_code"
        case email
        case orderID = "order_id"
        case paymentURL = "payment_url"
        case phone
        case subtotalPrice = "subtotal_price"
        case totalPrice = "total_price"
        case totalLineItemsPrice = "total_line_items_price"
        case lineItems = "line_items"
    }
}
