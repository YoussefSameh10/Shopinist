//
//  CustomerRepoStub.swift
//  ShopinistTests
//
//  Created by Youssef on 6/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine
@testable import Shopinist

class CustomerRepoStub: CustomerRepoProtocol {
    func getAllCustomers() -> Future<Customers, Error> {
        return Future { promise in
            promise(.success(Customers(customers: [])))
        }
    }
    
    func registerCustomer(customer: Customer) -> Future<PostCustomer, Error> {
        return Future { promise in
            promise(.success(PostCustomer(customer: nil)))
        }
    }
    
    func saveCustomerToUserDefaults(customer: Customer) {
        
    }
    
    func getCustomerFromUserDefaults() -> Customer? {
        return nil
    }
    
    func removeCustomerFromUserDefaults(id: Int) {
        
    }
    
    func getSelectedCurrency() -> String {
        return ""
    }
    
    
}
