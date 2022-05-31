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
    var productsList: [Product]?
    @Published var searchedProductsList: [Product]?
    var category: ProductCategory
    var subCategory: ProductType? {
        didSet {
            filterProductsForSearchText(searchText: "")
        }
    }

    init(productRepo: ProductsRepoProtocol, category: ProductCategory) {
        self.productRepo = productRepo
        self.category = category
        getProductsByCategory(category: category)
    }
    
    func filterProductsForSearchText(searchText: String) {
        
        filterProductBySubCategory()
        
        if !searchText.isEmpty {
            searchedProductsList = searchedProductsList?.filter { (product: Product) -> Bool in
                return product.title!.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    private func getProductsByCategory(category: ProductCategory) {
        observer = productRepo.getAllProductsOfCategory(category: category).sink(
            receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
        }, receiveValue: { [weak self] (response) in
            self?.productsList = response.products
            //self.shownProductsList = response.products
            self?.filterProductBySubCategory()
            //self.observableProductsList = response.products
            self?.searchedProductsList = response.products
        })
    }
    
    private func filterProductBySubCategory() {
        if(subCategory == nil) {
            searchedProductsList = productsList
        }
        else {
            searchedProductsList = []
            
            searchedProductsList = productsList?.filter({ product in
                if product.productType == subCategory {
                    return true
                }
                return false
            })
        }
    }
}
