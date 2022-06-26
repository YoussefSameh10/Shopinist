//
//  ProductDetailsViewModelStub.swift
//  ShopinistTests
//
//  Created by Amr El Shazly on 26/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
@testable import Shopinist

class ProductDetailsViewModelStub : ProductDetailsViewModelProtocol {
    
    
    var product : Product?
    var productSize : String?
    var productColor : String?
    var productVariantId: Int?
    var favRepo : FavouritesProductRepoProtocol
    var cartRepo : CartItemsRepoProtocol
    var customerRepo : CustomerRepoProtocol
    var favProducts : [Product]?
    var cartProducts : [CartProduct]?
    
    // MARK: - Init
    
    
    init(product: Product , productRepo : FavouritesProductRepoProtocol , cartRepo : CartItemsRepoProtocol , customerRepo : CustomerRepoProtocol = CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())) {
        self.product = product
        self.favRepo = productRepo
        self.cartRepo = cartRepo
        self.customerRepo = customerRepo
        
    }
    
    func addToFav() {
        favProducts?.append(product!)
    }
    
    func addToCart(variantID: Int) {
        <#code#>
    }
    
    func isInFavourite() -> Bool {
        <#code#>
    }
    
    func removeFavFromDb() {
        <#code#>
    }
    
    func getCartProducts() {
        <#code#>
    }
    
    func getSelectedCurrency() -> String {
        <#code#>
    }
    
    func isLoggedIn() -> Bool {
        <#code#>
    }
    
    
    
    
    
}

