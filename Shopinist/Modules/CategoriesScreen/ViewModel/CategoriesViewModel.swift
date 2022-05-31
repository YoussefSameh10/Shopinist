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
    var category: ProductCategory?
    var subCategory: ProductType? {
        didSet {
            filterProductsForSearchText(searchText: "")
        }
    }

    init(productRepo: ProductsRepoProtocol, products: [Product], category: ProductCategory) {
        self.productRepo = productRepo
        self.category = category
        productsList = products
        filterProductBySubCategory()
        searchedProductsList = products
    }
    
    func filterProductsForSearchText(searchText: String) {
        
        filterProductBySubCategory()
        
        if !searchText.isEmpty {
            searchedProductsList = searchedProductsList?.filter { (product: Product) -> Bool in
                return product.title!.lowercased().contains(searchText.lowercased())
            }
        }
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
