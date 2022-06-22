//
//  OrderDetailsViewModel.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/7/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation


class OrderDetailsViewModel : OrderDetailsViewModelProtocol{
    
    //MARK:- Properties
    private var order : Order
    private var orderIndex : Int
    private var customerRepo : CustomerRepoProtocol = CustomerRepo.getInstance()
    
    init(order : Order, index : Int){
        self.order = order
        self.orderIndex = index
    }
    
    //MARK:- Functions
    func getItemsCount() -> Int {
        return order.orderItems!.count
    }
    
    func getOrderItem(at: Int) -> OrderItem {
        return order.orderItems![at]
    }
    
    func getOrderId() -> Int {
        return order.id!
    }
    
    func getTotalPrice() -> String {
        let currency = self.getCurrency()
        return "\(order.totalPrice!) \(currency)"
    }
    
    func getOrderIndex() -> Int {
        return orderIndex + 1
    }
    
    func getCurrency() -> String {
        return customerRepo.getSelectedCurrency()
    }
}
