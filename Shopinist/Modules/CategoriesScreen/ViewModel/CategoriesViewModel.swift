//
//  CategoriesViewModel.swift
//  Shopinist
//
//  Created by Youssef on 5/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class CategoriesViewModel {
    
    private let productRepo: ProductsRepoProtocol
    
    private var observer: AnyCancellable?
    @Published var observableProductsList: [Product]?
    var productsList: [Product]?
    var shownProductsList: [Product]?

    init(productRepo: ProductsRepoProtocol) {
        self.productRepo = productRepo
        getProductsByCategory(category: .Men)
    }
    
    func getProductsByCategory(category: ProductCategory) {
        observer = productRepo.getAllProductsOfCategory(category: category).sink(
            receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
        }, receiveValue: { (response) in
            self.observableProductsList = response.products
        })
    }
    
    func filterProductBySubCategory(category: ProductType?) {
        if(category == nil) {
            shownProductsList = productsList
        }
        else {
            productsList?.forEach({ (product) in
                if(product.productType == category) {
                    shownProductsList?.append(product)
                }
            })
        }
    }
}
