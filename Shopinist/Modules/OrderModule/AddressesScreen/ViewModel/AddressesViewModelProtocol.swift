//
//  AddressesViewModelProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/17/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol AddressesViewModelProtocol {
    var customerAddresses: Published<[Address]?>.Publisher {get}
    var order: Order! {get set}
    
    func getaddressesCount() -> Int
    
    func getCustomerAddress(retrievedIndex : Int) -> Address
    
}
