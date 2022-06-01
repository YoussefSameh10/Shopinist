//
//  FavouritesDataBasaManagerProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 01/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol FavouritesDataBaseManagerProtocol {
    
    func getAllFavourites() -> [Product]
    func isInFavorites(id: Int) -> Bool 
    func addToFavDb(product : Product)
    func remove(product : Product)
    func getFavItemFromDbWithId(id: Int) -> [FavoriteProduct]
}
