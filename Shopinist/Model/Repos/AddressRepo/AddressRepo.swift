//
//  AddressRepo.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class AddressRepo : AddressRepoProtocol {
    
    private static var instance: AddressRepoProtocol?
    private var networkManager: NetworkManagerProtocol
    
    private init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    static func getInstance(networkManager: NetworkManagerProtocol) -> AddressRepoProtocol{
        if instance == nil {
            instance = AddressRepo(networkManager: networkManager)
        }
        return instance!
    }
    
    
    func createNewAddress(address: Address , customerID : Int) -> Future<PostAddress, Error> {
        let postAddress = PostAddress(address: address)
        do {
            let postBody = try JSONEncoder().encode(postAddress)
            print(postBody)
            return self.networkManager.postRequest(fromEndpoint: EndPoints.createNewAddress(customerID: customerID).endPoint, httpBody: postBody, httpMethod: .post, ofType: PostAddress.self)
        }
        catch let error {
            return Future { promise in
                promise(.failure(error))
            }
        }
    }
    
    func getAddressesOfCustomer(customerID: Int) -> Future<Addresses, Error> {
        return networkManager.getRequest(fromEndpoint: EndPoints.getAddressesOfCustomer(customerID: customerID).endPoint, parameters: nil, ofType: Addresses.self)
    }
    
    func deleteExistingAddress(address: Address , customerID : Int) -> Future<PostAddress, Error> {
        let postAddress = PostAddress(address: address)
        do {
            let postBody = try JSONEncoder().encode(postAddress)
            
            return self.networkManager.postRequest(fromEndpoint: EndPoints.updateExistingAddress(customerID: customerID, addressID: address.id ?? 0).endPoint, httpBody: postBody, httpMethod: .delete, ofType: PostAddress.self)
        }
        catch let error {
            return Future { promise in
                promise(.failure(error))
            }
        }
    }
    
    
}
