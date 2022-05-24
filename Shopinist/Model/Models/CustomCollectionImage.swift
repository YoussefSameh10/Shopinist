//
//  CustomCollectionImage.swift
//  Shopinist
//
//  Created by Amr El Shazly on 24/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Image
class CustomCollectionImage: Codable {
    
    var width, height: Int?
    var src: String?

    enum CodingKeys: String, CodingKey {
        case width, height, src
    }

    init(width: Int?, height: Int?, src: String?) {
        self.width = width
        self.height = height
        self.src = src
    }
}
