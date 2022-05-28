//
//  HomeViewModel.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class HomeViewModel{
    private let productsRepo : ProductsRepoProtocol
    private var cancellables : Set<AnyCancellable> = []
    
    @Published var brands : [String]?
    
    init(productsRepo : ProductsRepoProtocol){
        self.productsRepo = productsRepo
        getBrands()
    }
    
    func getBrands(){
        productsRepo.getAllProducts().sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                print("Finished")
            case .failure(let error):
                print("Error: \(error)")
            }
        }) { [weak self] (response) in
            self?.brands = self?.getBrandsFromProductsResponse(products: response.products ?? [])
        }.store(in: &cancellables)
    }
    private func getBrandsFromProductsResponse(products : [Product]) -> [String]{
        var brandsSet : Set<String> = []
        products.forEach{
            product in
            brandsSet.insert(product.vendor ?? "N/A")
        }
        
        let result : [String] = Array(brandsSet)
        print(result)
        return result
    }
}
