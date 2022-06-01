//
//  FavouritesViewModel.swift
//  Shopinist
//
//  Created by Amr El Shazly on 01/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation


class FavouritesViewModel : FavouritesViewModelProtocol {
    
    
    var productRepo : ProductsRepoProtocol
    var products : [Product]?
    
    init(productRepo : ProductsRepoProtocol) {
        self.productRepo = productRepo
    }
    
    
    func getFavouritesFromDB(){
        productRepo.getAllFavouritesFromDb()
    }
    
}
