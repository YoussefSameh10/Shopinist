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
    
    
    func addToFavDb(product : Product , customerEmail : String) {
        
        let favProduct = productToFavouriteProduct(product: product)
        favProduct.setValue(customerEmail, forKey: "email")
        do
        {
            try self.viewContext.save()
            print("*** product added *** ")
            //print(favProduct)
            
            print("productc added = \(favProduct.title) \(favProduct.sizes)")
            print("productc added = \(favProduct.title)  \(favProduct.colors)")
            print("**** fav product email = \(favProduct.email) **** ")

        }
        catch
        {
            print("Cannot be added !!!")
        }
    }
    
    
    private func productToFavouriteProduct(product: Product) -> FavoriteProduct {
        
        let favouriteProduct = FavoriteProduct(entity: self.entity, insertInto: viewContext)
        favouriteProduct.id = Int64(product.id!)
        favouriteProduct.title = product.title!
        favouriteProduct.price = product.variants![0].price
        favouriteProduct.details = product.description!

        // color
        favouriteProduct.colors = product.options?[1].values?[0] ?? ""
        
        // size
        var sizesStr = ""
        for size in product.options![0].values! {
            sizesStr.append(contentsOf: size)
            sizesStr.append("|")
        }
        sizesStr.removeLast()
        favouriteProduct.sizes = sizesStr
        
        var imagesStr = ""
        for image in product.images! {
            imagesStr.append(contentsOf: image.src!)
            imagesStr.append("|")
        }
        
        imagesStr.removeLast()
        
        favouriteProduct.images = imagesStr
        return favouriteProduct
    }
    
    
    // MARK: - Check In fav
    
    func isInFavorites(id: Int , customerEmail : String) -> Bool {
        if getFavItemFromDbWithId(id: id, customerEMail: customerEmail).isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - getAllFavourites
    
    func getAllFavourites(customerEmail : String) -> [Product] {
        let fetchRequest = NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
        fetchRequest.predicate = NSPredicate(format: "email == %@", customerEmail)
        var favouritesProducts : [FavoriteProduct]?
        do{
            favouritesProducts = try viewContext.fetch(fetchRequest)
        }catch let error {
            print(error.localizedDescription)
        }
        var products : [Product]
        products = Formatter.convertFavouriteProductsToProducts(favouriteProducts: favouritesProducts!)
        //print(products[0])

        return products
    }
    
    
    
    // MARK: - getProductWithId
    
    func getFavItemFromDbWithId(id: Int , customerEMail : String) -> [FavoriteProduct] {
        let fetchRequest = NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
        let idPredicate = NSPredicate(format: "id == %@ ", NSNumber(integerLiteral: id))
        let emailPredicate = NSPredicate(format: "email == %@", customerEMail)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [idPredicate,emailPredicate])
        //fetchRequest.predicate = NSPredicate(format: "id == %@ ", NSNumber(integerLiteral: id))
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
    
    func remove(product : Product , customerEmail : String){
        print(product.id)
        //var productToDelete = productToStoredProduct(product: product)
        var productToDelete = getFavItemFromDbWithId(id: product.id!, customerEMail: customerEmail)
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
