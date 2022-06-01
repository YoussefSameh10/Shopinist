//
//  FavouritesDataBasaManager.swift
//  Shopinist
//
//  Created by Amr El Shazly on 01/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import CoreData


class FavouritesDataBaseManager : FavouritesDataBaseManagerProtocol {
    
    // MARK: - Variables
    
    var appDelegate: AppDelegate!
    var viewContext : NSManagedObjectContext!
    var entity : NSEntityDescription!
    
    private static var instance: FavouritesDataBaseManagerProtocol?
    
    
    // MARK: - Init
    
    private init(appDelegate: AppDelegate){
        self.appDelegate = appDelegate
        self.viewContext = self.appDelegate.persistentContainer.viewContext
        self.entity = NSEntityDescription.entity(forEntityName: "FavoriteProduct", in: self.viewContext)
    }
    
    static func getInstance(appDelegate: AppDelegate) -> FavouritesDataBaseManagerProtocol {
        if instance == nil {
            instance = FavouritesDataBaseManager(appDelegate: appDelegate)
        }
        return instance!
    }
    
    // MARK: - Add Product To DB
    
    
    func addToFavDb(product : Product) {
        
        let storedProduct = productToStoredProduct(product: product)
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
    
    
    private func productToStoredProduct(product: Product) -> FavoriteProduct {
        
        let storedProduct = FavoriteProduct(entity: self.entity, insertInto: viewContext)
        storedProduct.id = Int64(product.id!)
        storedProduct.title = product.title!
        storedProduct.colors = product.options?[1].values?[0] ?? ""
        storedProduct.sizes = product.options?[0].values?[0] ?? ""
        storedProduct.details = product.description!
        
        var imagesStr = ""
        for image in product.images! {
            imagesStr.append(contentsOf: image.src!)
            imagesStr.append("|")
        }
        
        imagesStr.removeLast()
        
        storedProduct.images = imagesStr
        return storedProduct
    }
    
    
    // MARK: - Check In fav
    
    func isInFavorites(id: Int) -> Bool {
        if getFavItemFromDbWithId(id: id).isEmpty {
            return false
        }
        return true
    }
    
    
    //    private func isProductExists(id: Int, isFavorite: String) -> Bool {
    //        if getProducts(id: id).isEmpty {
    //            return false
    //        }
    //        return true
    //    }
    
    
    // MARK: - getAllFavourites
    
    func getAllFavourites() -> [Product] {
        let fetchRequest = NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
        
        var favouritesProducts : [FavoriteProduct]?
        do{
            favouritesProducts = try viewContext.fetch(fetchRequest)
        }catch let error {
            print(error.localizedDescription)
        }
        var products : [Product]
        products = Formatter.convertStoredProductsToProducts(storedProducts: favouritesProducts!)
        return products
    }
    
    
    
    // MARK: - getProductWithId
    
    func getFavItemFromDbWithId(id: Int) -> [FavoriteProduct] {
        let fetchRequest = NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
        fetchRequest.predicate = NSPredicate(format: "id == %@ ", NSNumber(integerLiteral: id))
        var products: [FavoriteProduct] = []
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
    
    func remove(product : Product){
        print(product.id)
        //var productToDelete = productToStoredProduct(product: product)
        var productToDelete = getFavItemFromDbWithId(id: product.id!)
        print(productToDelete[0].title)
        print(productToDelete[0].id)
        self.viewContext.delete(productToDelete[0])
        print("*** product removed *** ")
        
        do{
            try self.viewContext.save()
        }
        catch{
            print("Item didn't delete successfully !!")
        }
    }
    
    
}
