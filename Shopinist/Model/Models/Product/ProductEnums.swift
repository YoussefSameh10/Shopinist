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

enum ProductCategory : String {
    case Men = "400221307115"
    case Women = "400221339883"
    case Kids = "400221372651"
    case Sales = "400221405419"
}
