//
//  FavouritesViewModel.swift
//  Shopinist
//
//  Created by Amr El Shazly on 01/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation


class FavouritesViewModel : FavouritesViewModelProtocol {
    
    var products: [Product]?
    
    var favouritesRepo : FavouritesProductRepoProtocol
    
    init(favouritesRepo : FavouritesProductRepoProtocol) {
        self.favouritesRepo = favouritesRepo
    }
    
    
    func getFavouritesFromDB() -> [Product]{
        products = favouritesRepo.getAllFavouritesFromDb()
        return products!
    }
    
    func removeFavouritesItemFromRepo(product : Product){
        favouritesRepo.removeFavProductFromDb(product: product)
    }
    
}
