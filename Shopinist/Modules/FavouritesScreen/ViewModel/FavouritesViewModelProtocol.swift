//
//  FavouritesViewModelProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 01/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation


protocol FavouritesViewModelProtocol {
    
    var products : [Product]? {get}
    
    func getFavouritesFromDB() -> [Product]
    
    func removeFavouritesItemFromRepo(product : Product)
    
    func getCustomerFromUserDefaults() -> Customer?
}
