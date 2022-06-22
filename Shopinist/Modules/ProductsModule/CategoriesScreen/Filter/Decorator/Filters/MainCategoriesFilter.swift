//
//  MainCategoriesFilter.swift
//  Shopinist
//
//  Created by Youssef on 6/5/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class MainCategoriesFilter: Filter {
    var filterDecorator: FilterProductsDecorator
    var mainCategory: ProductCategory
    
    init(filterDecorator: FilterProductsDecorator, mainCategory: ProductCategory) {
        self.filterDecorator = filterDecorator
        self.mainCategory = mainCategory
    }
    
    func getProducts() -> [Product] {
        let products = filterDecorator.getProducts()
        let keyword = getKeywordForCategory()
        let filteredProducts = products.filter { product in
            return product.tags?.contains(keyword) ?? false
        }
        return filteredProducts
    }
}

extension MainCategoriesFilter {
    
    private func getKeywordForCategory() -> String {
        if mainCategory == ProductCategory.Men {
            return " men"
        }
        else if mainCategory == ProductCategory.Women {
            return "women"
        }
        else if mainCategory == ProductCategory.Kids {
            return "kid"
        }
        else {
            return "sales"
        }
    }
}
