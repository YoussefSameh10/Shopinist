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
    let customerRepo : CustomerRepoProtocol
    
    @Published private var _cartProducts : [CartProduct]?
    var cartProducts: Published<[CartProduct]?>.Publisher {$_cartProducts}
    
    
    //MARK:- Functions
    init(cartRepo : CartItemsRepoProtocol, custRepo : CustomerRepoProtocol = CustomerRepo.getInstance()){
        self.cartRepo = cartRepo
        self.customerRepo = custRepo
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
            _cartProducts?.remove(at: index)
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
    
    func getTotalPrice() -> Double {
        guard let products = _cartProducts else{
            return 0.0
        }
        var ret = 0.0
        for product in products {
            
            if let price = product.price{
                let cnt = Int(product.count)
                ret = ret + (Double(cnt) * Double(price)!)
            }
        }
        return ret
    }
    
    func createOrder() -> Order {
        let products = _cartProducts!
        let orderItems = products.map { (item : CartProduct) -> OrderItem in
            OrderItem(id: nil, giftCard: nil, productExists: nil, productID: Int(item.id), quantity: Int(item.count), title: item.title, totalDiscount: nil, variantID: nil, price: item.price)
        }
        let customer = customerRepo.getCustomerFromUserDefaults();
        let totalPrice = String(format: "%.2f", getTotalPrice())
        
        let newOrder = Order(customer: customer!, orderItems: orderItems, totalPrice: totalPrice)
        return newOrder
    }
}
