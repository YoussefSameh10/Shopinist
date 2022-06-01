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

class ProductDetailsViewModel : ProductDetailsViewModelProtocol{
    
    var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    
    var product : Product?
    var productRepo : FavouritesProductRepoProtocol
    var cartRepo : CartItemsRepoProtocol
    var favProducts : [Product]?
    var cartProducts : [CartProduct]?
    
    
    
    init(product: Product , productRepo : FavouritesProductRepoProtocol , cartRepo : CartItemsRepoProtocol) {
        self.product = product
        self.productRepo = productRepo
        self.cartRepo = cartRepo
        
    }
    
    
    func addToFav(){
        productRepo.addProductIntoFavouritesDb(product: product!)
    }
    
    func addToCart(size : String , color : String){
        cartRepo.add(cartItem: product!, size: size, color: color)
    }
    
    func isInFavourite() -> Bool{
        return productRepo.isInFavourites(id: (product?.id)!)
    }
    
    func removeFavFromDb(){
        productRepo.removeFavProductFromDb(product: product!)
    }
    
    // ************** just for test core data then remove it **********
    
    func getFavProducts(){
        favProducts = productRepo.getAllFavouritesFromDb()
        print("*** fav count = \(favProducts?.count) ***")
        //print("fav item name = \(favProducts?[0].title)")
    }
    
    func getCartProducts(){
        cartProducts = cartRepo.getAllItems()
        if cartProducts != nil {
            print("*** cart count = \(cartProducts?.count) ***")
            print("*** cart count = \(cartProducts?[0]) ***")
        }
    }
    
//    func removeCartProductFromDb(){
//        productRepo.removeCartProductFromDb(product: product!)
//    }
    
}
