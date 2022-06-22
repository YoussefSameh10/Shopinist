//
//  RegisterViewModelProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

protocol RegisterViewModelProtocol {
    var validEmail: Published<Bool?>.Publisher {get}
    
    func registerCustomer(name: String, email: String, password: String, address: String)
    func isCustomerLoggedIn() -> Bool
}
