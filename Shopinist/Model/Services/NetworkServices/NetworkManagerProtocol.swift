//
//  NetworkManagerProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 25/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Alamofire
import Combine

protocol NetworkManagerProtocol {
    
    func getRequest<T: Decodable>(fromEndpoint: EndPoints,parameters: Parameters? , ofType : T.Type) -> Future<T,Error>
    
    func postRequest<T: Decodable>(fromEndpoint: EndPoints, httpBody: Data, httpMethod : HTTPMethod , ofType : T.Type) -> Future<T,Error>
}
