//
//  PriceRulesRepo.swift
//  Shopinist
//
//  Created by Youssef on 6/7/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class PriceRulesRepo: PriceRulesRepoProtocol {
    private static var instance: PriceRulesRepoProtocol?
    private var networkManager: NetworkManagerProtocol
    private init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    static func getInstance(networkManager: NetworkManagerProtocol = NetworkManager.getInstance()) -> PriceRulesRepoProtocol {
        
        if instance == nil {
            instance = PriceRulesRepo(networkManager: networkManager)
        }
        return instance!
    }
    
    func getPriceRules() -> Future<PriceRules, Error> {
        return networkManager.getRequest(fromEndpoint: EndPoints.getPriceRules.endPoint, parameters: nil, ofType: PriceRules.self)
    }
}
