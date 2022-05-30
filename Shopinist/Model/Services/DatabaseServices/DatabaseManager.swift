//
//  DatabaseManager.swift
//  Shopinist
//
//  Created by Youssef on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager: DatabaseManagerProtocol{
    
    var appDelegate: AppDelegate!
    var viewContext : NSManagedObjectContext!
    var entity : NSEntityDescription!
    
    private static var instance: DatabaseManagerProtocol?

    private init(appDelegate: AppDelegate){
        self.appDelegate = appDelegate
        self.viewContext = self.appDelegate.persistentContainer.viewContext
        self.entity = NSEntityDescription.entity(forEntityName: "StoredProduct", in: self.viewContext)
    }
    
    static func getInstance(appDelegate: AppDelegate) -> DatabaseManagerProtocol {
        if instance == nil {
            instance = DatabaseManager(appDelegate: appDelegate)
        }
        return instance!
    }
    

    func getAllFavourites() -> [Product] {
        let fetchRequest = NSFetchRequest<StoredProduct>(entityName: "StoredProduct")
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %@", true)
        var favouritesProducts : [StoredProduct]?
        do{
             favouritesProducts = try viewContext.fetch(fetchRequest)
        }catch let error {
            print(error.localizedDescription)
        }
        var products : [Product]
        products = Formatter.convertStoredProductsToProducts(storedProducts: favouritesProducts!)
        return products
    }
    
    func getCartProduct() -> [Product] {
        
        let fetchRequest = NSFetchRequest<StoredProduct>(entityName: "StoredProduct")
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %@", false)
        var cartProducts : [StoredProduct]?
        do{
             cartProducts =  try viewContext.fetch(fetchRequest)
        }catch let error {
            print(error.localizedDescription)
        }
        var products : [Product]
        products = Formatter.convertStoredProductsToProducts(storedProducts: cartProducts!)
        return products
    }
    
    
    
    
    
}
