//
//  CustomerSettingsProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol CustomerSettingsRepoProtocol {
    
    func getCustomerFromUserDefaults() -> Customer?
    
    func saveSelectedCurrency(currency : SelectedCurrency)
    
    func getSelectedCurrency() -> String 
    
}
