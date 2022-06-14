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
    
    private var cancellables: Set<AnyCancellable> = []
    @Published private var productsList: [Product]?
    @Published private var searchedProducts: [Product]?
    private var brandName: String?
    var searchedProductsList: Published<[Product]?>.Publisher {$searchedProducts}
    var category: ProductCategory?
    var subCategory: ProductType? {
        didSet {
            filterProducts()
        }
    }
    var searchString: String = ""
    
    var filterType: FilterType = .NAME
    var filterDirection: FilterDirection = .ASCENDING
    var maxPrice: Int = 1000

    init(
        productRepo: ProductsRepoProtocol,
        category: ProductCategory,
        brandName: String? = nil
    ) {
        self.productRepo = productRepo
        self.category = category
        self.brandName = brandName
        getAllProducts()
    }
  
    private func getAllProducts() {
        productRepo.getAllProducts().sink(
            receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print(error)
                }
            },
            receiveValue: { (response) in
                self.productsList = response.products
                self.searchedProducts = self.productsList
                self.filterProducts()
            }
        ).store(in: &cancellables)
    }
    
    func filterProducts() {
        var coreProducts: FilterProductsDecorator = ProductsContainer(products: productsList ?? [])
        coreProducts = MainCategoriesFilter(filterDecorator: coreProducts, mainCategory: category ?? .Men)
        coreProducts = BrandFilter(filterDecorator: coreProducts, brandName: brandName)
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
