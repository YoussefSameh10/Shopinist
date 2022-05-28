//
//  Product.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    
    var id: Int?
    var title, description, vendor: String?
    var productType: ProductType?
    var tags: String?
    var variants: [Variant]?
    var options: [ProductOption]?
    var images: [ProductImage]?
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case id, title
        case description = "body_html"
        case vendor
        case productType = "product_type"
        case tags
        case variants, options, images
    }
}
