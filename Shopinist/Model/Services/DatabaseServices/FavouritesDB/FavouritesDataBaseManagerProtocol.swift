//
//  FavouritesDataBasaManagerProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 01/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol FavouritesDataBaseManagerProtocol {
    
    func getAllFavourites(customerEmail : String) -> [Product]
    func isInFavorites(id: Int , customerEmail : String) -> Bool 
    func addToFavDb(product : Product , customerEmail : String)
    func remove(product : Product)
    func getFavItemFromDbWithId(id: Int , customerEMail : String) -> [FavoriteProduct]
}
