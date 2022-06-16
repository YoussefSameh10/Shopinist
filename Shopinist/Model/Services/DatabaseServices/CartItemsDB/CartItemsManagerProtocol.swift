//
//  CartItemsManagerProtocol.swift
//  Shopinist
//
//  Created by Mohamed AMR on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol CartItemsManagerProtocol{
    func getAllItems() -> [CartProduct]?
    //func getItem(id : Int, size: String, color:String) -> CartProduct?
    func add(cartItem : Product, size: String, color: String , variantID : Int)
    func remove(id : Int, size: String, color: String)
    //func check(id : Int, size: String, color: String) -> Bool
    func update(id: Int, size: String, color: String, count: Int)
}
