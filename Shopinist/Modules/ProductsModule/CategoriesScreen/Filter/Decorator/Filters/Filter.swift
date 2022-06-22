//
//  Filter.swift
//  Shopinist
//
//  Created by Youssef on 6/4/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol Filter: FilterProductsDecorator {
    var filterDecorator: FilterProductsDecorator {get set}
}
