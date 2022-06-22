//
//  PostAddress.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation


struct PostAddress : Codable {
    var address : Address?
    
    enum CodingKeys: String, CodingKey {
        case address = "customer_address"
    }
}
