//
//  FavouritesProductRepo.swift
//  Shopinist
//
//  Created by Amr El Shazly on 01/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class FavouritesProductRepo  : FavouritesProductRepoProtocol{
    
    // MARK: - Variables
    
    private static var instance : FavouritesProductRepo?
    private var databaseManager : FavouritesDataBaseManagerProtocol
    
    
    // MARK: - Init
    
    private init(databaseManager : FavouritesDataBaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    static func getInstance(databaseManager : FavouritesDataBaseManagerProtocol) -> FavouritesProductRepo{
        if instance == nil{
            instance = FavouritesProductRepo(databaseManager:databaseManager)
        }
        return instance!
    }
    
    // MARK: - Methods
    
    func addProductIntoFavouritesDb(product : Product , customerEmail : String){
        databaseManager.addToFavDb(product: product , customerEmail: customerEmail)
    }
    

    func getAllFavouritesFromDb(customerEmail : String) -> [Product]{
        return databaseManager.getAllFavourites(customerEmail: customerEmail)
    }
    
    func isInFavourites(id:Int , customerEmail : String) -> Bool {
        return databaseManager.isInFavorites(id: id, customerEmail: customerEmail)
    }
   
    func removeFavProductFromDb(product : Product , customerEmail : String){
        databaseManager.remove(product: product, customerEmail: customerEmail)
    }
    
}
