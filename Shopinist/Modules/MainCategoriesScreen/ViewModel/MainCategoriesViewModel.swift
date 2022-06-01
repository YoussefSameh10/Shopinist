//
//  MainCategoriesViewModel.swift
//  Shopinist
//
//  Created by Youssef on 5/31/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class MainCategoriesViewModel: MainCategoriesViewModelProtocol {
    private var productsRepo: ProductsRepoProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var products: [Product]?
    var filteredProducts: [Product]?
    
    let titles = [
        "men",
        "women",
        "kids",
        "sales"
    ]
    
    var category: ProductCategory? {
        didSet {
            filterProductsByCategory()
        }
    }
    
    init(productsRepo: ProductsRepoProtocol) {
        self.productsRepo = productsRepo
        getAllProducts()
    }
    
    private func getAllProducts() {
        productsRepo.getAllProducts().sink(
            receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            },
            receiveValue: { [weak self] (response) in
                self?.products = response.products
            }
        ).store(in: &cancellables)
    }
    
    private func filterProductsByCategory() {
        let keyword = getKeywordForCategory()
        filteredProducts = products?.filter({ (product) -> Bool in
            if product.tags?.contains(keyword) ?? false {
                return true
            }
            return false
        })
    }
    
    private func getKeywordForCategory() -> String {
        if category == ProductCategory.Men {
            return " men"
        }
        else if category == ProductCategory.Women {
            return "women"
        }
        else if category == ProductCategory.Kids {
            return "kid"
        }
        else {
            return "sales"
        }
    }
}
