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
    
    // MARK: - Variables
    
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
    
    // MARK: - getAllFavourites
    
    func getAllFavourites() -> [Product] {
        let fetchRequest = NSFetchRequest<StoredProduct>(entityName: "StoredProduct")
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %@", "true")
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
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %@", "false")
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
    
    // MARK: - Remove Product From DB
    
    func remove(product : Product, isFav :String){
        let productToDelete = productToStoredProduct(product: product)
        //productToDelete.isFavorite = isFav
        self.viewContext.delete(productToDelete)
        do{
            try self.viewContext.save()
        }
        catch{
            print("Item didn't delete successfully !!")
        }
    }
    
    // MARK: - Add Product To DB
    
    func add(product : Product, isFav : String) {
        var storedProduct = productToStoredProduct(product: product)
        
        storedProduct.setValue(isFav, forKey: "isFavorite")
        
        
        //var imgStr = product.images!.reduce(""){ $0.src! + "|" + $1.src!}
        let isFound = false
//        do
//        {
//            try self.viewContext.save()
//        }
//        catch
//        {
//            print("Cannot be added !!!")
//        }
        if (isFound){
            storedProduct.setValue(storedProduct.count + 1, forKey: "count")
            if (isFav == "false"){
                //TODO: Update
            }
        }
        else{
            do
            {
                try self.viewContext.save()
            }
            catch
            {
                print("Cannot be added !!!")
            }
        }
    }
    
    private func productToStoredProduct(product: Product) -> StoredProduct {
        let storedProduct = StoredProduct(entity: self.entity, insertInto: viewContext)
        storedProduct.id = Int64(product.id!)
        storedProduct.title = product.title!
        storedProduct.color = product.options?[1].values?[0] ?? ""
        storedProduct.size = product.options?[0].values?[0] ?? ""
        storedProduct.details = product.description!
        //storedProduct.isFavorite = true
        
        
        //var imgStr = product.images!.reduce(""){ $0.src! + "|" + $1.src!}
        
        var imagesStr = ""
        for image in product.images! {
            imagesStr.append(contentsOf: image.src!)
            imagesStr.append("|")
        }
        
        imagesStr.removeLast()
        
        storedProduct.images = imagesStr
        return storedProduct
    }
}
