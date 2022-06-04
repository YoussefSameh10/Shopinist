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
        let customerEmail = getCustomerFromUserDefaults()?.email
        products = favouritesRepo.getAllFavouritesFromDb(customerEmail: customerEmail ?? "noEmail")
        return products!
    }
    
    func removeFavouritesItemFromRepo(product : Product){
        let customerEmail = customerRepo.getCustomerFromUserDefaults()?.email
        favouritesRepo.removeFavProductFromDb(product: product, customerEmail: customerEmail ?? "noEmail")
    }
    func getCustomerFromUserDefaults() -> Customer? {
        return customerRepo.getCustomerFromUserDefaults()
    }
    
    
    
}
