//
//  CartRepoStub.swift
//  ShopinistTests
//
//  Created by Amr El Shazly on 26/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
@testable import Shopinist

class CartRepoStub : CartItemsRepoProtocol {
    
    var item = Product(id: 10, title: "shoes", description: "this is a shoes ", vendor: "Nike")
    var cartItems : [Product] = []
    
    
    
    func getAllItems() -> [CartProduct]? {
        cartItems.append(item)
        cartItems.append(item)
        print("cart repo get all items method")

        return nil
    }
    
    func add(cartItem: Product, size: String, color: String, variantID: Int)
    {
        print("cart repo added method")
    }
    
    func remove(id: Int, size: String, color: String) {
        print("cart repo removed method")
    }
    
    func update(id: Int, size: String, color: String, count: Int) {
        print("cart repo updated method")
    }
    
    func deleteAll(email: String) {
        print("cart repo delete all method")
    }
    
    
}
