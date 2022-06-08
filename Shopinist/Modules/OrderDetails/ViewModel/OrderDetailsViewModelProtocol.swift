//
//  OrderDetailsViewModelProtocol.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/7/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol OrderDetailsViewModelProtocol{
    func getItemsCount() -> Int
    func getOrderItem(at: Int) -> OrderItem
    func getOrderId() -> Int
    func getTotalPrice() -> String
    func getOrderIndex() -> Int
    func getCurrency() -> String
}
