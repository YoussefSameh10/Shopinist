//
//  LoginViewModelProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol {
    var isValidLogin: Published<Bool?>.Publisher {get}
    func login(email: String, password: String)
}
