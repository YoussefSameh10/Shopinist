//
//  DatabaseManagerProtocol.swift
//  Shopinist
//
//  Created by Youssef on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol DatabaseManagerProtocol {
    //getAllFavorites/Cart
    //getOne(for checking purposes)
    func isInFavorites(id: Int) -> Bool
    func isInCart(id: Int) -> Bool
    //add
    //update
    func updateProductCountInCart(product: Product, count: Int)
    //delete
}
