//
//  Product.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Product
class Product: Codable {
    
    var id: Int?
    var title, description, vendor: String?
    var productType: ProductType?
    var createdAt: Date?
    var updatedAt, publishedAt: Date?
    var status: ProductStatus?
    var tags: String?
    var variants: [Variant]?
    var options: [ProductOption]?
    var images: [ProductImage]?

    enum CodingKeys: String, CodingKey {
        case id, title
        case description = "body_html"
        case vendor
        case productType = "product_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case status
        case tags
        case variants, options, images
    }

    init(id: Int?, title: String?, description: String?, vendor: String?, productType: ProductType?, createdAt: Date?, updatedAt: Date?, publishedAt: Date?, status: ProductStatus?,tags: String?, variants: [Variant]?, options: [ProductOption]?, images: [ProductImage]?) {
        self.id = id
        self.title = title
        self.description = description
        self.vendor = vendor
        self.productType = productType
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.publishedAt = publishedAt
        self.status = status
        self.tags = tags
        self.variants = variants
        self.options = options
        self.images = images
    }
}
