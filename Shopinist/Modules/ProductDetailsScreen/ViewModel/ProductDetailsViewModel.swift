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
    
    // MARK: - Variables
    
    var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    
    var product : Product?
    var productSize : String?
    var productColor : String?
    var favRepo : FavouritesProductRepoProtocol
    var cartRepo : CartItemsRepoProtocol
    var customerRepo : CustomerRepoProtocol
    var favProducts : [Product]?
    var cartProducts : [CartProduct]?
    
    // MARK: - Init
    
    init(product: Product , productRepo : FavouritesProductRepoProtocol , cartRepo : CartItemsRepoProtocol , customerRepo : CustomerRepoProtocol = CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())) {
        self.product = product
        self.favRepo = productRepo
        self.cartRepo = cartRepo
        self.customerRepo = customerRepo
        
    }
    
    // MARK: - Functions
    
    func addToFav(){
        let customerEmail = customerRepo.getCustomerFromUserDefaults()?.email
        favRepo.addProductIntoFavouritesDb(product: product!, customerEmail: customerEmail ?? "noEmail")
    }
    
    func addToCart(){
        
        print("addToCart: size = \(productSize), color = \(product?.options![0].name)")
        productColor =  product?.options![1].values![0]
        if productSize != nil {
            cartRepo.add(cartItem: product!, size: productSize!, color:(product?.options![1].values![0])!)
        }
    }
    
    func isInFavourite() -> Bool{
        let customerEmail = customerRepo.getCustomerFromUserDefaults()?.email
        return favRepo.isInFavourites(id: (product?.id)!, customerEmail: customerEmail ?? "noEmail")
    }
    
    func removeFavFromDb(){
        let customerEmail = customerRepo.getCustomerFromUserDefaults()?.email
        favRepo.removeFavProductFromDb(product: product!, customerEmail: customerEmail ?? "noEmail")
    }
    
    // ************** just for test core data then remove it **********
    
//    func getFavProducts(){
//        favProducts = productRepo.getAllFavouritesFromDb()
//        print("*** fav count = \(favProducts?.count) ***")
//        //print("fav item name = \(favProducts?[0].title)")
//    }
    
    func getCartProducts(){
        cartProducts = cartRepo.getAllItems()
        if cartProducts != nil {
            print("*** cart count = \(cartProducts?.count) ***")
            print("\n\n\nCart Products : \n")
            cartProducts?.forEach({ (cartProduct) in
                print("\(cartProduct.id) : \(cartProduct.count) : \(cartProduct.size) : \(cartProduct.color) \n\n" )
            })
        }
    }
    
    //    func removeCartProductFromDb(){
    //        productRepo.removeCartProductFromDb(product: product!)
    //    }
    
}
