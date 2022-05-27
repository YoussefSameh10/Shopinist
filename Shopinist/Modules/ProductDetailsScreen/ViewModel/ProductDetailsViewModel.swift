//
//  ProductDetailsViewModel.swift
//  Shopinist
//
//  Created by Amr El Shazly on 26/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class ProductDetailsViewModel {
    
    let productRepo = ProductsRepo.getInstance()
    var observer : AnyCancellable?
    @Published var response : Products?
    var products : [Product]?

    
    
    
    func getAllProducts(){
        observer = productRepo.getAllProducts().sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished :
                    print("finished")
                case .failure(let error) :
                    print(error)
                }
            }, receiveValue: { response in
                self.response = response
                self.products = response.products!
                print("*****************")
                print(response.products!.count)
                print(response.products![0])
                print("*****************")
                print(self.$response)
            })
    }
    
    
}
