//
//  ProductDetailsViewModel.swift
//  Shopinist
//
//  Created by Amr El Shazly on 26/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class ProductDetailsViewModel {
    
    var product : Product?
    
    init(product: Product) {
        self.product = product
    }
    
}
