//
//  ProductEnums.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

enum ProductOptionName: String, Codable {
    case color = "Color"
    case size = "Size"
}


enum ProductType: String, Codable {
    case accessories = "ACCESSORIES"
    case shoes = "SHOES"
    case tShirts = "T-SHIRTS"
}


enum ProductStatus: String, Codable {
    case active = "active"
    case draft = "draft"
    case archived = "archived"
}


enum FulfillmentService: String, Codable {
    case manual = "manual"
}


enum InventoryManagement: String, Codable {
    case shopify = "shopify"
}


enum InventoryPolicy: String, Codable {
    case deny = "deny"
    case allow = "continue"
}
