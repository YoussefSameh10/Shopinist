//
//  NetworkManager.swift
//  Shopinist
//
//  Created by Amr El Shazly on 25/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Alamofire
import Combine

class NetworkManager : NetworkManagerProtocol{
    
    private static var instance : NetworkManager?
    
    private init(){}
    
    static func getInstance() -> NetworkManager{
        if instance == nil{
            instance = NetworkManager()
        }
        return instance!
    }
    
    //MARK: - HttpMethod
    
    func getRequest<T: Decodable>(fromEndpoint: String,parameters: Parameters? , ofType : T.Type) -> Future<T,Error> {
        
        return Future { promise in
            guard let url = URL(string: "\(BASE_URL)\(fromEndpoint)") else {
                promise(.failure(Errors.invalidUrl))
                return
            }
            
            AF.request(url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding(destination:.queryString), headers: nil).responseJSON { (response) in
//                print(response.request)
                if let error = response.error {
                    promise(.failure(error))
                }
                
                guard let urlResponse = response.response else {
                    promise(.failure(Errors.invalidResponse))
                    return
                }
                if !(200..<300).contains(urlResponse.statusCode) {
                    promise(.failure(Errors.invalidStatusCode))
                }
                
                guard let data = response.data else { return }
                do {
                    print("gggggggggg")
                    let response = try JSONDecoder().decode(T.self, from: data)
                    promise(.success(response))
                } catch {
                    debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                    promise(.failure(error))
                }
            }
        }
    }
    
    func postRequest<T: Decodable>(fromEndpoint: String, httpBody: Data, httpMethod : HTTPMethod , ofType : T.Type) -> Future<T,Error> {
        
        return Future { promise in
            guard let url = URL(string: "\(BASE_URL)\(fromEndpoint)") else {
                promise(.failure(Errors.invalidUrl))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue
            let session = URLSession.shared
            request.httpShouldHandleCookies = false
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = httpBody
            request.httpShouldHandleCookies = false
            session.dataTask(with: request) { (data, response, error) in
                if let error = error{
                    print(error)
                    promise(.failure(error))
                }else{
                    if let data = data {
                        do{
                        let jsonDecoder = JSONDecoder()
                            let result = try jsonDecoder.decode(T.self, from: data)
                            promise(.success(result))
                        }catch{
                            promise(.failure(Errors.invalidResponse))
                        }
                    }
                }
            }.resume()
        }
    }
}


