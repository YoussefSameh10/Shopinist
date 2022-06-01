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
    
    // MARK: - Check
    
    func isInFavorites(id: Int) -> Bool {
        return isProductExists(id: id, isFavorite: "true")
    }
    
    func isInCart(id: Int) -> Bool {
        return isProductExists(id: id, isFavorite: "false")
    }
    
    // MARK: - UpdateProduct
    
    func updateProductCountInCart(product: Product, count: Int) {
        let products = getProducts(id: product.id!, isFavorite: "false")
        if products.isEmpty {
            return
        }
        
        if count == 0 {
            remove(product: product, isFav: "false")
            return
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
    
    // MARK: - getCartProducts
    
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
    
    private func isProductExists(id: Int, isFavorite: String) -> Bool {
        if getProducts(id: id, isFavorite: isFavorite).isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - getProductWithId
    
    func getProducts(id: Int, isFavorite: String) -> [StoredProduct] {
        let fetchRequest = NSFetchRequest<StoredProduct>(entityName: "StoredProduct")
        let predict1 = NSPredicate(format: "id == %@", NSNumber(integerLiteral: id))
        let perdicate2 = NSPredicate(format: "isFavorite == %@", isFavorite)
        let compundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predict1,perdicate2])
        fetchRequest.predicate = compundPredicate
        //fetchRequest.predicate = NSPredicate(format: "id == %@ AND isFavorite == %@", id, isFavorite)
        var products: [StoredProduct] = []
        do{
            products = try viewContext.fetch(fetchRequest)
            if products.count > 0 {
                print("****** get product from db \(products[0].id)")
                print("****** id param \(id)")
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
        print(product.id)
        //var productToDelete = productToStoredProduct(product: product)
        var productToDelete = getProducts(id: product.id!, isFavorite: isFav)
        productToDelete[0].setValue(isFav, forKey: "isFavorite")
        print(productToDelete[0].title)
        print(productToDelete[0].id)
        print(productToDelete[0].isFavorite)
        self.viewContext.delete(productToDelete[0])
        print("*** product removed *** ")

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
        
        let isFoundInFavorite = isProductExists(id: product.id ?? 0, isFavorite: "true")
        let isFoundInCart = isProductExists(id: product.id ?? 0, isFavorite: "false")
        
        if (isFoundInFavorite)
        {
            return
        }
        if (isFoundInCart){
            let foundProducts = getProducts(id: product.id ?? 0, isFavorite: "false")
                updateProductCountInCart(product: product, count: Int(foundProducts[0].count))
        }
        do
        {
            try self.viewContext.save()
            print("*** product added *** ")
            print("productc added = \(product.title) **** \(product.id)")
        }
        catch
        {
            print("Cannot be added !!!")
        }
    }
    
    // MARK: - MapProductToStoredProduct
    
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

