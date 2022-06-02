//
//  CartViewModel.swift
//  Shopinist
//
//  Created by Mohamed AMR on 6/2/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class CartViewModel : CartViewModelProtocol{
    
    //MARK:- Variables
    let cartRepo : CartItemsRepoProtocol
    
    @Published private var _cartProducts : [CartProduct]?
    var cartProducts: Published<[CartProduct]?>.Publisher {$_cartProducts}
    
    
    //MARK:- Functions
    init(cartRepo : CartItemsRepoProtocol){
        self.cartRepo = cartRepo
        getCartItems()
    }
    
    func getCartItems() {
        _cartProducts = cartRepo.getAllItems()
    }
    
    func updateAll() {
        if (_cartProducts != nil && _cartProducts?.isEmpty == false){
            _cartProducts?.forEach({ (cartProduct) in
                cartRepo.update(id: Int(cartProduct.id), size: cartProduct.size!, color: cartProduct.color!, count: Int(cartProduct.count))
            })
        }
    }
    
    func removeItemAt(index : Int) {
        if (_cartProducts != nil && _cartProducts?.isEmpty == false){
            let itemToBeDeleted = _cartProducts![index]
            cartRepo.remove(id: Int(itemToBeDeleted.id), size: itemToBeDeleted.size!, color: itemToBeDeleted.color!)
        }
    }
    
    func getItemAt(index: Int) -> CartProduct? {
        guard let products = _cartProducts else{
            return nil
        }
        if (products.isEmpty == false){
            return products[index]
        }
        return nil
    }
    
    func decrementItemAt(index: Int) {
        if (_cartProducts != nil && _cartProducts?.isEmpty == false){
            let count = _cartProducts![index].count
            _cartProducts![index].setValue(count - 1, forKey: "count")
        }
    }
    
    func incrementItemAt(index: Int) {
        if (_cartProducts != nil && _cartProducts?.isEmpty == false){
            let count = _cartProducts![index].count
            _cartProducts![index].setValue(count + 1, forKey: "count")
        }
    }
    
    func getCartItemsCount() -> Int{
        return _cartProducts?.count ?? 0
    }
}
