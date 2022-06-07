//
//  AddressRepoProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

protocol AddressRepoProtocol {
    
    func createNewAddress(address: Address , customerID : Int) -> Future<PostAddress, Error>
    
    func getAddressesOfCustomer(customerID: Int) -> Future<Addresses, Error>
    
    func updateExistingAddress(address: Address , customerID : Int) -> Future<PostAddress, Error>
    
    
}
