//
//  ProductImage.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Image
class ProductImage: Codable {
    var id, productID: Int?
    var createdAt, updatedAt: Date?
    var width, height: Int?
    var src: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, src
    }

    init(id: Int?, productID: Int?, createdAt: Date?, updatedAt: Date?,  width: Int?, height: Int?, src: String?) {
        self.id = id
        self.productID = productID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.width = width
        self.height = height
        self.src = src
    }
}
