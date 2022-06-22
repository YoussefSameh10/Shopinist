//
//  ProductDetailsViewModelProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 31/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol ProductDetailsViewModelProtocol {
    
    var product : Product? {get}
    var productSize : String? {get set}
    var productColor : String? {get set}
    var productVariantId : Int? {get set}
    
    func addToFav()
    
    func addToCart(variantID : Int)
    
    func isInFavourite() -> Bool
    
    func removeFavFromDb()
            
    func getCartProducts()
    
    func getSelectedCurrency() -> String
    
}
