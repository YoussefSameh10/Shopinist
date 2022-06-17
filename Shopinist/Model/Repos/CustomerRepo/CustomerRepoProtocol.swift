//
//  CustomerRepoProtocol.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

protocol CustomerRepoProtocol{
    func getAllCustomers() -> Future<Customers, Error>
    func registerCustomer(customer : Customer) -> Future<PostCustomer, Error>
    
    func saveCustomerToUserDefaults(customer: Customer)
    func getCustomerFromUserDefaults() -> Customer?
    func removeCustomerFromUserDefaults(id: Int)
    
    func getSelectedCurrency() -> String
}
