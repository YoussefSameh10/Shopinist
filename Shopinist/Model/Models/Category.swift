//
//  CustomCollection.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Category
class Category: Codable {
    
    var id: Int?
    var title: String?
    var updatedAt: Date?
    var publishedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, title
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
    }

    init(id: Int?, title: String?, updatedAt: Date?, publishedAt: Date?) {
        self.id = id
        self.title = title
        self.updatedAt = updatedAt
        self.publishedAt = publishedAt
        
    }
}
