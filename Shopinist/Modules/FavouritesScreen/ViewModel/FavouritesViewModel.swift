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
    var customerRepo : CustomerRepoProtocol
    
    init(favouritesRepo : FavouritesProductRepoProtocol, customerRepo : CustomerRepoProtocol ) {
        self.favouritesRepo = favouritesRepo
        self.customerRepo = customerRepo
    }
    
    
    func getFavouritesFromDB() -> [Product]{
        products = favouritesRepo.getAllFavouritesFromDb()
        return products!
    }
    
    func removeFavouritesItemFromRepo(product : Product){
        favouritesRepo.removeFavProductFromDb(product: product)
    }
    func getCustomerFromUserDefaults() -> Customer? {
        return customerRepo.getCustomerFromUserDefaults()
    }
    
}
