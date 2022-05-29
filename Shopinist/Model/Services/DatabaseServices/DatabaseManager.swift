//
//  DatabaseManager.swift
//  Shopinist
//
//  Created by Youssef on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager: DatabaseManagerProtocol {
    
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
    
    func isInFavorites(id: Int) -> Bool {
        return isProductExists(id: id, isFavorite: true)
    }
    
    func isInCart(id: Int) -> Bool {
        return isProductExists(id: id, isFavorite: false)
    }
    
    func updateProductCountInCart(product: Product, count: Int) {
        let products = getProducts(id: product.id!, isFavorite: false)
        if products.isEmpty {
            return
        }
        
        if count == 0 {
            //delete
        }
        
        let product = products[0]
        product.count = Int64(count)
        do{
            try viewContext.save()
        }
        catch let error{
            print(error.localizedDescription)
        }
    }
}

extension DatabaseManager {
    
    private func isProductExists(id: Int, isFavorite: Bool) -> Bool {
        if getProducts(id: id, isFavorite: isFavorite).isEmpty {
            return false
        }
        return true
    }
    
    private func getProducts(id: Int, isFavorite: Bool) -> [StoredProduct] {
        let fetchRequest = NSFetchRequest<StoredProduct>(entityName: "StoredProduct")
        fetchRequest.predicate = NSPredicate(format: "id == %@ && isFavorite == %@", id, isFavorite)
        var products: [StoredProduct] = []
        do{
            products = try viewContext.fetch(fetchRequest)
            if products.count > 0 {
                return products
            }
            return []
        }
        catch let error{
            print(error.localizedDescription)
            return []
        }
    }
}
