//
//  ProductDetailsViewModel.swift
//  Shopinist
//
//  Created by Amr El Shazly on 26/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine
import UIKit

class ProductDetailsViewModel {
    
    var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    
    var product : Product?
    var productRepo : ProductsRepo
    var favProducts : [Product]?
    var cartProducts : [Product]?
    
    
    
    init(product: Product) {
        self.product = product
        productRepo  = ProductsRepo.getInstance(networkManager: NetworkManager.getInstance(), databseManager: DatabaseManager.getInstance(appDelegate: appDelegate))
    }
    
    
    func addToFav(){
        productRepo.addProductIntoFavouritesDb(product: product!)
    }
    
    func addToCart(){
        productRepo.addProductIntoCartDb(product: product!)
    }
    
    func getFavProducts(){
        favProducts = productRepo.getFavouritesFromDb()
        print("fav count = \(favProducts?.count)")
    }
    
    func getCartProducts(){
        cartProducts = productRepo.getCartProductsFromDb()
        print("cart count = \(cartProducts?.count)")
    }
    
    func removeFavFromDb(){
        productRepo.removeFavProductFromDb(product: product!)
    }
    
    func removeCartProductFromDb(){
        productRepo.removeCartProductFromDb(product: product!)
    }
    
}
