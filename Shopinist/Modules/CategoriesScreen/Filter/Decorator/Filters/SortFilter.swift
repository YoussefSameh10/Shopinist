//
//  SortFilter.swift
//  Shopinist
//
//  Created by Youssef on 6/4/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class SortFilter: Filter {
    var filterDecorator: FilterProductsDecorator
    var filterType: FilterType
    var filterDirection: FilterDirection
    
    init(filterDecorator: FilterProductsDecorator, filterType: FilterType, filterDirection: FilterDirection) {
        self.filterDecorator = filterDecorator
        self.filterType = filterType
        self.filterDirection = filterDirection
    }
    
    func getProducts() -> [Product] {
        let products = filterDecorator.getProducts()
        
        let filteredProducts: [Product] = products.sorted { (p1, p2) -> Bool in
            
            let t1 = Formatter.formatProductName(productTitle: p1.title!)
            let t2 = Formatter.formatProductName(productTitle: p2.title!)
            let price1 = Formatter.getIntPrice(from: p1.variants?[0].price ?? "0.0")
            let price2 = Formatter.getIntPrice(from: p2.variants?[0].price ?? "0.0")
            
            if filterType == .NAME && filterDirection == .ASCENDING {
                return t1 < t2
            }
            else if filterType == .NAME && filterDirection == .DESCENDING {
                return t1 > t2
            }
            else if filterType == .PRICE && filterDirection == .ASCENDING {
                return price1 < price2
            }
            else if filterType == .PRICE && filterDirection == .DESCENDING {
                return price1 > price2
            }
            else {
                return true
            }
        }
        
        return filteredProducts
    }
}
