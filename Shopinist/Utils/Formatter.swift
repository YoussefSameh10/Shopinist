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
        return String(parts[parts.count - 1])
    }
    
    static func formatStoredProductImage(storedProduct : StoredProduct) -> [String]{
        
        let images : [String] = storedProduct.images?.split(separator: "|") as! [String]
        return images
    }
    
    static func convertStoredProductsToProducts(storedProducts: [FavoriteProduct]) -> [Product] {
        
        return storedProducts.map { storedProduct -> Product in
            var product = Product()
            product.id = Int(storedProduct.id)
            product.title = storedProduct.title
            //product.options![0].values![0] = storedProduct.size ?? ""
            //product.options![1].values![0] = storedProduct.color ?? ""
            product.description! = storedProduct.details!
//            let images : [String] =  formatStoredProductImage(storedProduct: storedProduct)
//            for image in images {
//                product.images?.append(ProductImage(src: image))
//            }
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
        
        return product
    }
    
}
