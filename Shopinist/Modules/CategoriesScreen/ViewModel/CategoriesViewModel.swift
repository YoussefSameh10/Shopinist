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
    var searchedProductsList: [Product]?
    
    var subCategory: ProductType? {
        didSet {
            filterProductBySubCategory()
        }
    }

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
            self.productsList = response.products
            self.shownProductsList = response.products
            self.filterProductBySubCategory()
            self.observableProductsList = response.products
            })
    }
    
    private func filterProductBySubCategory() {
        if(subCategory == nil) {
            shownProductsList = productsList
        }
        else {
            shownProductsList = []
            productsList?.forEach({ (product) in
                if(product.productType == subCategory) {
                    shownProductsList?.append(product)
                }
            })
        }
    }
}
