//
//  NetworkStub.swift
//  ShopinistTests
//
//  Created by Youssef on 6/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Alamofire
import Combine
@testable import Shopinist

class NetworkManagerStub: NetworkManagerProtocol {
    func getRequest<T>(fromEndpoint: String, parameters: Parameters?, ofType: T.Type) -> Future<T, Error> where T : Decodable {
        return Future { promise in
            
        }
    }
    
    func postRequest<T>(fromEndpoint: String, httpBody: Data, httpMethod: HTTPMethod, ofType: T.Type) -> Future<T, Error> where T : Decodable {
        return Future { promise in
            
        }
    }
    
    
}
