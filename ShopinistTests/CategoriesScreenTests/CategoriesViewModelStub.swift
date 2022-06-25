//
//  CategoriesViewModelStub.swift
//  ShopinistTests
//
//  Created by Youssef on 6/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine
@testable import Shopinist

class CategoriesViewModelStub: CategoriesViewModelProtocol {
    
    var productRepo: ProductsRepoProtocol!
    var customerRepo: CustomerRepoProtocol!
    var searchedProductsList: Published<[Product]?>.Publisher {$searchedProducts}
    @Published private var productsList: [Product]?
    @Published private var searchedProducts: [Product]?
    var category: ProductCategory?
    var subCategory: ProductType?
    var searchString: String = ""
    var filterType: FilterType = .NAME
    var filterDirection: FilterDirection = .ASCENDING
    var maxPrice: Int = 1000
    var brandName: String?
    var cancellables: Set<AnyCancellable> = []
    
    init(
        productRepo: ProductsRepoProtocol,
        customerRepo: CustomerRepoProtocol = CustomerRepo.getInstance(),
        category: ProductCategory,
        brandName: String? = nil
    ) {
        self.productRepo = productRepo
        self.customerRepo = customerRepo
        self.category = category
        self.brandName = brandName
        getAllProducts()
    }
    
    func filterProducts() {
        let maxPriceFactored = customerRepo.getSelectedCurrency() == "EGP" ? maxPrice : maxPrice*18
        var coreProducts: FilterProductsDecorator = ProductsContainer(products: productsList ?? [])
        coreProducts = MainCategoriesFilter(filterDecorator: coreProducts, mainCategory: category ?? .Men)
        coreProducts = BrandFilter(filterDecorator: coreProducts, brandName: brandName)
        coreProducts = PriceFilter(filterDecorator: coreProducts, price: maxPriceFactored)
        coreProducts = SortFilter(filterDecorator: coreProducts, filterType: filterType, filterDirection: filterDirection)
        coreProducts = CategoriesFilter(filterDecorator: coreProducts, category: subCategory)
        coreProducts = SearchFilter(filterDecorator: coreProducts, searchString: searchString)
    }
    
    func isProductsListEmpty() -> Bool {
        return false
    }
    
    func getProductsCount() -> Int {
        return 0
    }
    
    func getProductAt(index: Int) -> Product? {
        return nil
    }
    
    func getProductPrice(price: String) -> String {
        return ""
    }
    
    func getAllProducts() {
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
    
    
}
