//
//  CartItemsRepo.swift
//  Shopinist
//
//  Created by Mohamed AMR on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class CartItemsRepo: CartItemsRepoProtocol {
    
    private var cartItemsManager: CartItemsManagerProtocol!
    private static var instance: CartItemsRepoProtocol?
    
    private init(cartItemsManager: CartItemsManagerProtocol) {
        self.cartItemsManager = cartItemsManager
    }
    
    static func getInstance(cartItemsManager: CartItemsManagerProtocol) -> CartItemsRepoProtocol {
        if instance == nil {
            instance = CartItemsRepo(cartItemsManager: cartItemsManager)
        }
        return instance!
    }
    
    func getAllItems() -> [CartProduct]? {
        return cartItemsManager.getAllItems()
    }
    
    func add(cartItem: Product, size: String, color: String , variantID : Int) {
        cartItemsManager.add(cartItem: cartItem, size: size, color: color, variantID: variantID)
    }
    
    func remove(id: Int, size: String, color: String) {
        cartItemsManager.remove(id: id, size: size, color: color)
    }
    
    func update(id: Int, size: String, color: String, count: Int) {
        cartItemsManager.update(id: id, size: size, color: color, count: count)
    }
    
    func deleteAll(email: String) {
        cartItemsManager.deleteAll(email: email)
    }
    
    
}
