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
    private var customerRepo : CustomerRepoProtocol = CustomerRepo.getInstance()
    
    
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
        let customerEmail = customerRepo.getCustomerFromUserDefaults()?.email ?? ""
        let fetchRequest = NSFetchRequest<CartProduct>(entityName: "CartProduct")
        fetchRequest.predicate = NSPredicate(format: "email == %@", customerEmail)
        var cartProducts : [CartProduct]?
        do{
            cartProducts =  try viewContext.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
        }
        return cartProducts
    }
    
    func getItem(id: Int, size: String, color:String) -> CartProduct? {
        print("========= getItem ============")
        guard let cartProducts = getAllItems() else{
            return nil
        }
        
        if (cartProducts.count > 0){
            
            let customerEmail = customerRepo.getCustomerFromUserDefaults()?.email
            let filteredProducts = cartProducts.filter {
                (($0.id == id) && ($0.size == size) && ($0.color == color) && $0.email == customerEmail)
            }
            if (filteredProducts.count > 0)
            {
                let returnedProduct = filteredProducts[0]
                print("Item: id = \(returnedProduct.id), size = \(returnedProduct.size!), color = \(returnedProduct.color!)")
                return returnedProduct
            }
        }
        return nil
    }
    
    func add(cartItem: Product, size:String, color:String , variantID : Int) {
        print("========= Add ============")
        let isFound = check(id: cartItem.id ?? 0, size: size, color: color)

        if (isFound){
            let returnedProduct = getItem(id: cartItem.id ?? 0, size: size, color: color)!
            
            let count = Int(returnedProduct.count) + 1
            print("Old count = \(count - 1), newCount = \(count)")
            update(id: cartItem.id ?? 0, size: size, color: color, count: Int(returnedProduct.count) + 1)
            print("Cart Item updated Successfully !!")
            print("here cart db \(variantID)")
            return
        }
        
        _ = convertProductToCartProduct(product: cartItem, size: size, color: color, variantId: variantID)
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
        guard let returnedItem = getItem(id: id, size: size, color: color) else{
            print("Item didn't delete successfully !!")
            return
        }
        
        self.viewContext.delete(returnedItem)
        do{
            try self.viewContext.save()
        }
        catch{
            print("Item didn't delete successfully !!")
        }
        print("Cart Item deleted Successfully !!")
    }
    
    func check(id: Int, size:String, color:String) -> Bool {
        print("========= Check ============")
        guard getItem(id: id, size: size, color: color) != nil else{
            print("Mesh mawgoda !!")
            return false
        }
        print("Mawgoda !!")
        return true
    }
    
    func update(id: Int, size: String, color: String, count: Int){
        print("========= Update ============")
        let isFound = check(id: id, size: size, color: color)
        print("isFound = \(isFound)")
        print("id = \(id), size = \(size), color = \(color)")
        if (isFound == false){
            return
        }
        
        let returnedProduct = getItem(id: id, size: size, color: color)!
        returnedProduct.setValue(Int64(count), forKey: "count")
        
        print("Object to be updated: \n\n")
        print("id = \(returnedProduct.id), \(returnedProduct.count)")
        do{
            try viewContext.save()
        }
        catch let error{
            print(error.localizedDescription)
        }
    }
    
    func deleteAll() {
        guard let products : [CartProduct] = getAllItems() else{
            return
        }
        for product in products{
            let id = Int(product.id)
            let size = product.size ?? ""
            let color = product.color ?? ""
            
            remove(id: id, size: size, color: color)
        }
    }
    
    func deleteAll(email: String) {
        guard let products : [CartProduct] = getAllItems() else{
            return
        }
        for product in products{
            let id = Int(product.id)
            let size = product.size ?? ""
            let color = product.color ?? ""
            
            remove(id: id, size: size, color: color)
        }
    }
    
    private func convertProductToCartProduct(product: Product, size: String, color: String, variantId: Int, count: Int = 1) -> CartProduct{
        let cartProduct = CartProduct(entity: self.entity, insertInto: viewContext)
        
        cartProduct.id = Int64(product.id!)
        cartProduct.title = product.title
        cartProduct.vendor = product.vendor
        cartProduct.email = customerRepo.getCustomerFromUserDefaults()?.email
        cartProduct.count = Int64(count)
        cartProduct.image = product.images?[0].src
        cartProduct.color = color
        cartProduct.size = size
        cartProduct.details = product.description!
        cartProduct.tags = product.tags ?? ""
        cartProduct.price = product.variants![0].price!
        cartProduct.variantId = Int64(variantId)
        return cartProduct
    }
}
