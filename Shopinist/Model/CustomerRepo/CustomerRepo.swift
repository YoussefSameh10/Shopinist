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
    
    private let defaults = UserDefaults.standard
    
    private init(networkManager : NetworkManagerProtocol){
        self.networkManager = networkManager
    }
    
    static func getInstance(networkManager: NetworkManagerProtocol) -> CustomerRepoProtocol{
        if instance == nil {
            instance = CustomerRepo(networkManager: networkManager)
        }
        return instance!
    }
    
    func getAllCustomers() -> Future<Customers, Error> {
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
    
    func saveCustomerToUserDefaults(customer: Customer) {
        defaults.set(customer.id, forKey: ID)
        defaults.set(customer.firstName, forKey: NAME)
        defaults.set(customer.email, forKey: EMAIL)
        defaults.set(customer.tags, forKey: PASSWORD)
    }
    
    func getCustomerFromUserDefaults() -> Customer? {
        let id = defaults.integer(forKey: ID)
        if id == 0 {
            return nil
        }
        return Customer(
            id: id,
            name: defaults.object(forKey: NAME) as! String,
            email: defaults.object(forKey: EMAIL) as! String,
            password: defaults.object(forKey: PASSWORD) as! String
        )
    }
    
    func removeCustomerFromUserDefaults(id: Int) {
        defaults.removeObject(forKey: ID)
        defaults.removeObject(forKey: NAME)
        defaults.removeObject(forKey: EMAIL)
        defaults.removeObject(forKey: PASSWORD)
    }
}
