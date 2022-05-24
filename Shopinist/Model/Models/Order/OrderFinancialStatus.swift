//
//  FinancialStatus.swift
//  Shopinist
//
//  Created by Youssef on 5/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

enum OrderFinancialStatus: String, Codable {
    case pending = "pending"
    case authorized = "authorized"
    case partiallyPaid = "partially_paid"
    case paid = "paid"
    case partiallyRefunded = "partially_refunded"
    case refunded = "refunded"
    case voided = "voided"
}
