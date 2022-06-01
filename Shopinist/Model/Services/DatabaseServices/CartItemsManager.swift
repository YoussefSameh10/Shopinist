//
//  CartItemsManager.swift
//  Shopinist
//
//  Created by Mohamed AMR on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import CoreData

class CartItemsManager : CartItemsManagerProtocol{
    
    
    //MARK:- Variables
    var appDelegate: AppDelegate!
    var viewContext : NSManagedObjectContext!
    var entity : NSEntityDescription!
    
    //MARK:- Functions
    
    private static var instance : CartItemsManagerProtocol?
    
    private init(appDelegate: AppDelegate){
        self.appDelegate = appDelegate
        self.viewContext = self.appDelegate.persistentContainer.viewContext
        self.entity = NSEntityDescription.entity(forEntityName: "CartProduct", in: self.viewContext)
    }
    
    static func getInstance(appDelegate: AppDelegate) -> CartItemsManagerProtocol {
        if instance == nil {
            instance = CartItemsManager(appDelegate: appDelegate)
        }
        return instance!
    }
    
    func getAllItems() -> [CartProduct]? {
        let fetchRequest = NSFetchRequest<CartProduct>(entityName: "CartProduct")
        
        var cartProducts : [CartProduct]?
        do{
            cartProducts =  try viewContext.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
        }
        return cartProducts
    }
    
    func getItem(id : Int, size: String, color:String) -> CartProduct? {
        
        let fetchRequest = NSFetchRequest<CartProduct>(entityName: "CartProduct")
        
        var predicates : [NSPredicate] = []
        predicates.append(NSPredicate(format: "id == %@", NSNumber(integerLiteral: id)))
        predicates.append(NSPredicate(format: "size == %@", size))
        predicates.append(NSPredicate(format: "color == %@", color))
        
        let compundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        fetchRequest.predicate = compundPredicate
        
        do{
            var returnedProducts  : [CartProduct]?
            returnedProducts = try viewContext.fetch(fetchRequest)
            if (returnedProducts?.count ?? -1 > 0 ) {
                print("****** cartProduct from db \(returnedProducts![0].id)")
                print("****** id param \(id)")
                return returnedProducts![0]
            }
            return nil
        }
        catch let error{
            print(error.localizedDescription)
            return nil
        }
    }
    
    func add(cartItem: Product, size:String, color:String) {
//        let isFound = check(id: cartItem.id ?? 0, size: size, color: color)
//        
//        if (isFound){
//            let returnedProduct = getItem(id: cartItem.id ?? 0, size: size, color: color)
//            update(id: cartItem.id ?? 0, size: size, color: size, count: Int(returnedProduct?.count ?? 1) + 1)
//            print("Cart Item updated Successfully !!")
//            return
//        }
        let x = convertProductToCartProduct(product: cartItem, size: size, color: color)
        do
        {
            try self.viewContext.save()
            print("cart item added")
        }
        catch
        {
            print("Cannot be added !!!")
        }
        print("Cart Item added Successfully !!")
    }
    
    func remove(id: Int, size:String, color:String) {
        
        let returnedItem = getItem(id: id, size: size, color: color)
        
        self.viewContext.delete(returnedItem!)
        do{
            try self.viewContext.save()
        }
        catch{
            print("Item didn't delete successfully !!")
        }
        print("Cart Item deleted Successfully !!")
    }
    
    func check(id: Int, size:String, color:String) -> Bool {
        let cartItem = getItem(id: id, size: size, color: color)
        
        if (cartItem == nil){
            return false
        }
        return true
    }
    
    func update(id: Int, size: String, color: String, count: Int){
        let isFound = check(id: id, size: size, color: color)
        if (isFound == false){
            return
        }
        
        let returnedProduct = getItem(id: id, size: size, color: color)!
        if(count == 0){
            remove(id: id, size: size, color: color)
            return
        }
        
        returnedProduct.count = Int64(count)
        do{
            try viewContext.save()
        }
        catch let error{
            print(error.localizedDescription)
        }
    }
    
    private func convertProductToCartProduct(product: Product, size: String, color: String, count: Int = 1) -> CartProduct{
        let cartProduct = CartProduct(entity: self.entity, insertInto: viewContext)
        
        cartProduct.id = Int64(product.id!)
        cartProduct.title = product.title!
        cartProduct.vendor = product.vendor!
        cartProduct.email = ""
        cartProduct.count = Int64(count)
        //cartProduct.image = product.images?[0].src!
        cartProduct.color = color
        cartProduct.size = size
        cartProduct.details = product.description!
        cartProduct.tags = product.tags!
        
        return cartProduct
    }
}
