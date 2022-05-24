//
//  Variant.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Variant
class Variant: Codable {
    var id, productID: Int?
    var price, sku: String?
    var inventoryPolicy: InventoryPolicy?
    var compareAtPrice: String?
    var fulfillmentService: FulfillmentService?
    var inventoryManagement: InventoryManagement?
    var productSize: String?
    var productColor: String?
    var option3: String?
    var createdAt, updatedAt: Date?
    var taxable: Bool?
    var inventoryItemID, inventoryQuantity: Int?
    var requiresShipping: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case price, sku
        case inventoryPolicy = "inventory_policy"
        case compareAtPrice = "compare_at_price"
        case fulfillmentService = "fulfillment_service"
        case inventoryManagement = "inventory_management"
        case productSize, productColor, option3
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxable
        case inventoryItemID = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case requiresShipping = "requires_shipping"
    }

    init(id: Int?, productID: Int?, price: String?, sku: String?, inventoryPolicy: InventoryPolicy?, compareAtPrice: String?, fulfillmentService: FulfillmentService?, inventoryManagement: InventoryManagement?, productSize: String?, productColor: String?, option3: String?, createdAt: Date?, updatedAt: Date?, taxable: Bool?,inventoryItemID: Int?, inventoryQuantity: Int?, requiresShipping: Bool?) {
        
        self.id = id
        self.productID = productID
        self.price = price
        self.sku = sku
        self.inventoryPolicy = inventoryPolicy
        self.compareAtPrice = compareAtPrice
        self.fulfillmentService = fulfillmentService
        self.inventoryManagement = inventoryManagement
        self.productSize = productSize
        self.productColor = productColor
        self.option3 = option3
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.taxable = taxable
        self.inventoryItemID = inventoryItemID
        self.inventoryQuantity = inventoryQuantity
        self.requiresShipping = requiresShipping
    }
}
