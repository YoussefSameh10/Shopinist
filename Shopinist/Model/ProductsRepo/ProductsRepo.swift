//
//  ProductsRepo.swift
//  Shopinist
//
//  Created by Amr El Shazly on 26/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class ProductsRepo : ProductsRepoProtocol {
    
    private static var instance : ProductsRepo?
    private var networkManager: NetworkManagerProtocol
    
    private init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    static func getInstance(networkManager: NetworkManagerProtocol) -> ProductsRepo{
        if instance == nil{
            instance = ProductsRepo(networkManager: networkManager)
        }
        return instance!
    }
    
    func getAllProducts() -> Future<Products,Error> {
        
        let networkCall = networkManager.getRequest(fromEndpoint: EndPoints.getAllProducts.endPoint, parameters: nil, ofType: Products.self)
        return networkCall
    }
    
    func getAllProductsOfCategory(category : ProductCategory) -> Future<Products,Error>{
        
        let networkCall = networkManager.getRequest(fromEndpoint:EndPoints.getProductsOfCategory(categoryId: category.rawValue).endPoint, parameters: nil, ofType: Products.self)
        return networkCall
    }
    
    
    
}
