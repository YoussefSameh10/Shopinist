//
//  CustomCollections.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Categories
class Categories: Codable {
    
    var categories: [Category]?

    enum CodingKeys: String, CodingKey {
        case categories = "custom_collections"
    }

    init(categories: [Category]?) {
        self.categories = categories
    }
}




