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
    
}
