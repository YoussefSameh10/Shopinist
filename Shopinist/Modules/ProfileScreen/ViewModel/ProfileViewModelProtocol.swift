//
//  ProfileViewModelProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 02/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation


protocol ProfileViewModelProtocol {
    
    var customerOrders: Published<[Order]?>.Publisher {get}
    
    func getCustomerOrdersList()
    func switchToUSD()
    func switchToEGP()
    
}