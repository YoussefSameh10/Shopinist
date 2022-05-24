//
//  CustomCollection.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    
    var id: Int?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
    }
}
