//
//  SettingsViewModelProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol SettingsViewModelProtocol {
    
    var validAddress: Published<Address?>.Publisher {get}
    var customerAddresses: Published<[Address]?>.Publisher {get}
    
    func createNewAddress(address : String)
    
    func getCustomerAddresses()
    
    func updateCustomerAddress(address : String)
    
    func saveSelectedCurrrency(selectedCurrency : SelectedCurrency)

    func getSelectedCurrency() -> String
    
    func getaddressesCount() -> Int
    
    
}
