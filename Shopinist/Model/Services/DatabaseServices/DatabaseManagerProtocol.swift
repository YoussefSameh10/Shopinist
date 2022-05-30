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
    //add
    //update
    //delete
    func getAllFavourites() -> [Product]
    func getCartProduct() -> [Product]
}
