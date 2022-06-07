//
//  CheckoutViewModelProtocol.swift
//  Shopinist
//
//  Created by Youssef on 6/7/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

protocol CheckoutViewModelProtocol {
    var isPaymentCash: Bool {get set}
    var priceRule: String? {get set}
    var isValidPriceRule: Published<Bool?>.Publisher {get}
    var validPriceRule: PriceRule? {get set}
    var priceAfterDiscount: Int? {get set}
    
    func validatePromoCode()
    func postOrder()
}
