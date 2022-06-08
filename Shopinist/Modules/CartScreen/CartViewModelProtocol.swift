//
//  CartViewModelProtocol.swift
//  Shopinist
//
//  Created by Mohamed AMR on 6/2/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

protocol CartViewModelProtocol {
    var cartProducts : Published<[CartProduct]?>.Publisher {get}
    
    func getCartItems()
    func updateAll()
    func removeItemAt(index : Int)
    func getItemAt(index : Int) -> CartProduct?
    func decrementItemAt(index : Int)
    func incrementItemAt(index : Int)
    func getCartItemsCount() -> Int
    func getTotalPrice() -> Double
}
