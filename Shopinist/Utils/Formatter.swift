//
//  Formatter.swift
//  Shopinist
//
//  Created by Youssef on 5/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class Formatter {
    
    static func formatProductName(productTitle: String) -> String {
        let parts = productTitle.split(separator: "|")
        return String(parts[parts.count - 1])
    }
}
