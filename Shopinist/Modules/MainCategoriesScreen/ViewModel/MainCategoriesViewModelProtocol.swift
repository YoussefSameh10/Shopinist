//
//  MainCategoriesViewModelProtocol.swift
//  Shopinist
//
//  Created by Youssef on 5/31/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol MainCategoriesViewModelProtocol {

    var brandName: String? {get set}
    var category: ProductCategory? {get set}
    var titles: [String] {get}
}
