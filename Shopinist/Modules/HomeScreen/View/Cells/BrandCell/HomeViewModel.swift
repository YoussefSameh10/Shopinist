//
//  HomeViewModel.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class HomeViewModel : HomeViewModelProtocol{
    private let productsRepo : ProductsRepoProtocol
    private var cancellables : Set<AnyCancellable> = []
    
    @Published private var _brands : [String]?
    var brands: Published<[String]?>.Publisher {$_brands}
    
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
            self?._brands = self?.getBrandsFromProductsResponse(products: response.products ?? [])
        }.store(in: &cancellables)
    }
    
    private func getBrandsFromProductsResponse(products : [Product]) -> [String]{
        var brandsSet : Set<String> = []
        products.forEach{
            product in
            brandsSet.insert(product.vendor ?? "N/A")
        }
        
        let result : [String] = Array(brandsSet)
        return result
    }
    
    func getBrandsCount() -> Int{
        return _brands?.count ?? 0
    }
    
    func getBrand(at: Int) -> String {
        return _brands?[at] ?? "adidas"
    }
}
