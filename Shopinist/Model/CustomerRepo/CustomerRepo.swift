//
//  CustomerRepo.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class CustomerRepo : CustomerRepoProtocol{
    
    private static var instance : CustomerRepoProtocol?
    private var networkManager : NetworkManagerProtocol
    
    private init(networkManager : NetworkManagerProtocol){
        self.networkManager = networkManager
    }
    
    static func getInstance(networkManager: NetworkManagerProtocol) -> CustomerRepoProtocol{
        if instance == nil {
            instance = CustomerRepo(networkManager: networkManager)
        }
        return instance!
    }
    
    func getAllCustomers(customer: Customer) -> Future<Customers, Error> {
        return networkManager.getRequest(fromEndpoint: EndPoints.getAllCustomers.endPoint, parameters: nil, ofType: Customers.self)
    }
    
    func registerCustomer(customer: Customer) -> Future<PostCustomer, Error> {
        do {
            let customerData = try JSONEncoder().encode(PostCustomer(customer : customer))
            
            return networkManager.postRequest(fromEndpoint: EndPoints.getAllCustomers.endPoint, httpBody: customerData, httpMethod: .post, ofType: PostCustomer.self)
        }
        catch let error {
            return Future { promise in
                promise(.failure(error))
            }
        }
        
    }
}
