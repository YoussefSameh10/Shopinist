//
//  OrderRepoProtocol.swift
//  Shopinist
//
//  Created by Youssef on 5/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

protocol OrderRepoProtocol {
    func createOrder(order: Order) -> Future<PostOrder, Error>
    func getOrdersOfCustomer(customerID: Int) -> Future<Orders, Error>
}
