//
//  OrderRepo.swift
//  Shopinist
//
//  Created by Youssef on 5/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class OrderRepo: OrderRepoProtocol {
    
    private static var instance: OrderRepoProtocol?
    private var networkManager: NetworkManagerProtocol
    
    private init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    static func getInstance(networkManager: NetworkManagerProtocol) -> OrderRepoProtocol{
        if instance == nil {
            instance = OrderRepo(networkManager: networkManager)
        }
        return instance!
    }
    
    
    func createOrder(order: Order) -> Future<PostOrder, Error> {
        let postOrder = PostOrder(order: order)
        do {
            let postBody = try JSONEncoder().encode(postOrder)
            
            return self.networkManager.postRequest(fromEndpoint: EndPoints.createOrder.endPoint, httpBody: postBody, httpMethod: .post, ofType: PostOrder.self)
        }
        catch let error {
            return Future { promise in
                promise(.failure(error))
            }
        }
    }
    
    func getOrdersOfCustomer(customerID: Int) -> Future<Orders, Error> {
        return networkManager.getRequest(fromEndpoint: EndPoints.getOrdersOfCustomer(customerID: customerID).endPoint, parameters: nil, ofType: Orders.self)
    }
    
}
