//
//  CategoriesViewModel.swift
//  Shopinist
//
//  Created by Youssef on 5/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class CategoriesViewModel: CategoriesViewModelProtocol {
    
    
    
    private let productRepo: ProductsRepoProtocol
    
    private var observer: AnyCancellable?
    var productsList: [Product]?
    @Published private var searchedProducts: [Product]?
    var searchedProductsList: Published<[Product]?>.Publisher {$searchedProducts}
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
        searchedProducts = products
    }
    
    func filterProductsForSearchText(searchText: String) {
        
        filterProductBySubCategory()
        
        if !searchText.isEmpty {
            searchedProducts = searchedProducts?.filter { (product: Product) -> Bool in
                return product.title!.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func isProductsListEmpty() -> Bool {
        return searchedProducts?.isEmpty ?? true
    }
    
    func getProductsCount() -> Int {
        return searchedProducts?.count ?? 0
    }
    
    func getProductAt(index: Int) -> Product? {
        return searchedProducts![index]
    }
    
    
}

extension CategoriesViewModel {
    private func filterProductBySubCategory() {
        if(subCategory == nil) {
            searchedProducts = productsList
        }
        else {
            searchedProducts = []
            
            searchedProducts = productsList?.filter({ product in
                if product.productType == subCategory {
                    return true
                }
                return false
            })
        }
    }
}
