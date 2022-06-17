//
//  HomeViewModelProtocol.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/9/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
    
    var brands: Published<[String]?>.Publisher {get}
    
    func getBrands()
    func getBrandsCount() -> Int
    func getBrand(at : Int) -> String
}
