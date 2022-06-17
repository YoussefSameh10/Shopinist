//
//  CategoriesViewModelProtocol.swift
//  Shopinist
//
//  Created by Youssef on 5/31/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol CategoriesViewModelProtocol: CategoriesFilterViewModelProtocol {
    var searchedProductsList: Published<[Product]?>.Publisher {get}
    var category: ProductCategory? {get}
    var subCategory: ProductType? {get set}
    var searchString: String {get set}
    
    func isProductsListEmpty() -> Bool
    //func filterProductsForSearchText(searchText: String)
    func getProductsCount() -> Int
    func getProductAt(index: Int) -> Product?
    func getProductPrice(price: String) -> String
}
