//
//  EndPoint.swift
//  Shopinist
//
//  Created by Amr El Shazly on 25/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

enum EndPoints {
    
    case getAllCustomers
    
    //MARK: - Products EndPoints
    
    case getAllProducts
    case getProductsOfCategory(categoryId : String)
    case createOrder
    case getOrdersOfCustomer(customerID: Int)
    case getPriceRules
    
    var endPoint : String {
        switch self {
        case .getAllCustomers:
            return "/admin/api/2021-04/customers.json"
        case .getAllProducts:
            return "/admin/api/2022-04/products.json"
        case .getProductsOfCategory(categoryId: let categoryId):
            return "/admin/api/2022-04/collections/\(categoryId)/products.json"
        case .createOrder:
            return "/admin/api/2022-04/orders.json"
        case .getOrdersOfCustomer(customerID: let customerID):
            return "/admin/api/2022-04/customers/\(customerID)/orders.json"
        case .getPriceRules:
            return "/admin/api/2022-04/price_rules.json"
        }
    }

}


