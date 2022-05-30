//
//  ProductImage.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Image
struct ProductImage: Codable {
    var id, productID: Int?
    var src: String?
    
    init(src : String){
        self.src = src
    }

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case src
    }
}
