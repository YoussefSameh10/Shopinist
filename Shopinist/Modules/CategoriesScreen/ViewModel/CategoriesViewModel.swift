//
//  CategoriesViewModel.swift
//  Shopinist
//
//  Created by Youssef on 5/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class CategoriesViewModel: CategoriesViewModelProtocol, CategoriesFilterViewModelProtocol {
    
    private let productRepo: ProductsRepoProtocol
    
    private var observer: AnyCancellable?
    var productsList: [Product]?
    @Published private var searchedProducts: [Product]?
    var searchedProductsList: Published<[Product]?>.Publisher {$searchedProducts}
    var category: ProductCategory?
    var subCategory: ProductType? {
        didSet {
            //filterProductsForSearchText(searchText: "")
            filterProducts()
        }
    }
    var searchString: String = ""
    
    var filterType: FilterType = .NAME
    var filterDirection: FilterDirection = .ASCENDING
    var maxPrice: Int = 1000

    init(
        productRepo: ProductsRepoProtocol,
        products: [Product],
        category: ProductCategory
    ) {
        self.productRepo = productRepo
        self.category = category
        productsList = products
        filterProducts()
        searchedProducts = products
    }
  
    
    func filterProducts() {
        var coreProducts: FilterProductsDecorator = ProductsContainer(products: productsList ?? [])
        coreProducts = PriceFilter(filterDecorator: coreProducts, price: maxPrice)
        coreProducts = SortFilter(filterDecorator: coreProducts, filterType: filterType, filterDirection: filterDirection)
        coreProducts = CategoriesFilter(filterDecorator: coreProducts, category: subCategory)
        coreProducts = SearchFilter(filterDecorator: coreProducts, searchString: searchString)
        searchedProducts = coreProducts.getProducts()
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
//    private func filterProductBySubCategory() {
//        if(subCategory == nil) {
//            searchedProducts = productsList
//        }
//        else {
//            searchedProducts = []
//
//            searchedProducts = productsList?.filter({ product in
//                if product.productType == subCategory {
//                    return true
//                }
//                return false
//            })
//        }
//    }
}
