//
//  Formatter.swift
//  Shopinist
//
//  Created by Youssef on 5/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class Formatter {
    
    static func formatProductName(productTitle: String) -> String {
        let parts = productTitle.split(separator: "|")
        var ret = String(parts[parts.count - 1])
        if let index  = ret.firstIndex(of: " ") {
            ret.remove(at: index)
        }
        return ret
    }
    
    static func formatStringToArray(str : String) -> [String]{
        
        let images = str.split(separator: "|")
        var imagesStr : [String] = []
        //        imagesStr = String(images)
        for image in images {
            imagesStr.append(String(image))
        }
        return imagesStr
    }
    
    
    
    static func separateStringArray(stringArray : [String]) -> String {
        var str = ""
        for element in stringArray {
            str.append(contentsOf: element)
            str.append("|")
        }
        str.removeLast()
        return str
    }
    
    static func convertFavouriteProductsToProducts(favouriteProducts: [FavoriteProduct]) -> [Product] {
        
        
        
        return favouriteProducts.map { favouriteProduct -> Product in
            var product = Product()
            var colors : [String] = []
            var sizes : [String] = []
            colors.append(favouriteProduct.colors!)
            print("**** fav product sizes converted **** \(favouriteProduct.sizes)")
            sizes = formatStringToArray(str: favouriteProduct.sizes!)
            //sizes.append(favouriteProduct.sizes!)
            
            product.id = Int(favouriteProduct.id)
            if !favouriteProduct.price!.isEmpty {
                print(favouriteProduct.price)
            }
            else{
                print("noooooooo priceeeeee")
            }
            print(favouriteProduct.price)
            product.variants = []
            product.variants?.append(Variant(price: favouriteProduct.price))
            //product.variants![0].price = favouriteProduct.price
            //print("after convert \(product.variants![0].price)")
            product.title = favouriteProduct.title
            product.options?.append(ProductOption(name: .size, values:sizes))
            product.options?.append(ProductOption(name: .color, values:colors))
            product.description! = favouriteProduct.details!
            let images : [String] = formatStringToArray(str: (favouriteProduct.images)!)
            product.images = []
            for image in images {
                product.images?.append(ProductImage(src: image))
            }
            return product
        }
    }
    
    static func convertCartProductToProduct(cartProduct: CartProduct) -> Product {
        var product = Product()
        
        product.id = Int(cartProduct.id)
        product.title = cartProduct.title
        product.description = cartProduct.details
        product.vendor = cartProduct.vendor
        product.tags = cartProduct.tags
        product.options = [ProductOption(id: nil, productID: nil, name: .color, values: [cartProduct.color!])]
        product.images = [ProductImage(id: nil, productID: nil, src: cartProduct.image)]
        product.variants = [Variant(id: nil, productID: nil, price: cartProduct.price, productSize: nil, productColor: nil, inventoryQuantity: nil)]
        return product
    }
    
    static func getIntPrice(from doubleStr: String) -> Int {
        return Int(exactly: Double(doubleStr)?.rounded() ?? 0.0) ?? 0
    }
    
    static func convertPriceCurrency(to : Currency , price : Int) -> String{
        if to == .USD {
            return String(price / 18)
        }
        else{
            return String(price * 18)
        }
    }
    
    static func convertPriceCurrency(to : Currency , price : Double) -> Double{
        if to == .USD {
            return price / 18
        }
        else{
            return price * 18
        }
    }
    
    enum Currency : String{
        case USD = "USD"
        case EGP = "EGP"
    }
    
    static func getPriceInDollars(egpPrice: String) -> String {
        let priceEGP = getIntPrice(from: egpPrice)
        let dollarPrice = priceEGP/18
        return "\(dollarPrice)"
    }
    
    static func dataFormatter( date : String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date: NSDate? = dateFormatter.date(from: date) as NSDate?
        
    }

    static func formatPriceIntoString(price : Double, currency: String) -> String{
        let currCurrency = (currency == "EGP") ? Currency.EGP : Currency.USD
        let newPrice = convertPriceCurrency(to: currCurrency, price: price)
        print("This is new Price = \(newPrice)")
        return String(format: "%.2f \(currCurrency.rawValue)", newPrice)
    }
    
    
}
