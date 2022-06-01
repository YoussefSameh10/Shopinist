//
//  CategoriesViewModelProtocol.swift
//  Shopinist
//
//  Created by Youssef on 5/31/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol CategoriesViewModelProtocol {
    var searchedProductsList: Published<[Product]?>.Publisher {get}
    var productsList: [Product]? {get set}
    var category: ProductCategory? {get}
    var subCategory: ProductType? {get set}
    
    func filterProductsForSearchText(searchText: String)
    func getProductsCount() -> Int
    func getProductAt(index: Int) -> Product?
}
