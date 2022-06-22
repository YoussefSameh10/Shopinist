//
//  FavouritesProductRepoProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 01/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol FavouritesProductRepoProtocol {
    
    func addProductIntoFavouritesDb(product : Product , customerEmail : String)
        
    func getAllFavouritesFromDb(customerEmail : String) -> [Product]
    
    func isInFavourites(id:Int , customerEmail : String) -> Bool
    
    func removeFavProductFromDb(product : Product , customerEmail : String)
    
}
