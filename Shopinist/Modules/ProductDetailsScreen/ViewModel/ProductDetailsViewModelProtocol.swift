//
//  ProductDetailsViewModelProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 31/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol ProductDetailsViewModelProtocol {
    func addToFav()
    
    func addToCart()
    
    func isInFavourite() -> Bool
    
    func removeFavFromDb()
    
    // ************** just for test core data then remove it **********
    
    func getFavProducts()
    
    func getCartProducts()
    
    func removeCartProductFromDb()
    
}
