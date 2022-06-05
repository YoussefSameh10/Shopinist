//
//  Address.swift
//  Shopinist
//
//  Created by Youssef on 5/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    
    var id, customerID: Int?
    var address: String?
    var city, country: String?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case address, city, country
    }
    
    init(address: String) {
        self.address = address
    }
    
    init(address: String , customerID : Int) {
        self.address = address
        self.customerID = customerID
    }
    
    init(id: Int? = nil, customerID: Int? = nil, address: String? = nil, city: String? = nil, country: String? = nil) {
        self.id = id
        self.customerID = customerID
        self.address = address
        self.city = city
        self.country = country
    }
}
