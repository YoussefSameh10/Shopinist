//
//  CheckoutViewModel.swift
//  Shopinist
//
//  Created by Youssef on 6/7/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class CheckoutViewModel: CheckoutViewModelProtocol {
    
    
    var isPaymentCash: Bool = true
    var priceRule: String?
    
    
    private var priceRulesRepo: PriceRulesRepoProtocol!
    private var ordersRepo: OrderRepoProtocol!
    private var customerRepo: CustomerRepoProtocol!
    private var cartItemsRepo: CartItemsRepoProtocol!
    var order: Order?
    var address: Address?
    
    private var cancellables: Set<AnyCancellable> = []
    @Published private var priceRules: [PriceRule]?
    
    @Published private var _isValidPriceRule: Bool?
    var isValidPriceRule: Published<Bool?>.Publisher {$_isValidPriceRule}
    var validPriceRule: PriceRule?
    var priceAfterDiscount: Int?
    
    @Published private var _isOrderPlaced: Bool?
    var isOrderPlaced: Published<Bool?>.Publisher {$_isOrderPlaced}
    
    init(
        priceRulesRepo: PriceRulesRepoProtocol = PriceRulesRepo.getInstance(),
        ordersRepo: OrderRepoProtocol = OrderRepo.getInstance(),
        customerRepo: CustomerRepoProtocol = CustomerRepo.getInstance(),
        cartItemsRepo: CartItemsRepoProtocol,
        order: Order?
    ) {
        self.priceRulesRepo = priceRulesRepo
        self.ordersRepo = ordersRepo
        self.customerRepo = customerRepo
        self.cartItemsRepo = cartItemsRepo
        self.order = order
        priceAfterDiscount = Formatter.getIntPrice(from: order?.totalPrice ?? "0.0")
    }
    
    func getOrderPrice() -> String {
        if customerRepo.getSelectedCurrency() == "EGP" {
            return "\((order?.totalPrice)!)"
        }
        else {
            return "\((Formatter.getPriceInDollars(egpPrice: (order?.totalPrice)!)))"
        }
    }
    
    func getOrderPriceAfterDiscount() -> String {
        if customerRepo.getSelectedCurrency() == "EGP" {
            return "\(priceAfterDiscount!)"
        }
        else {
            return "\((Formatter.getPriceInDollars(egpPrice: String(priceAfterDiscount!))))"
        }
    }
    
    func getCurrency() -> String {
        if customerRepo.getSelectedCurrency() == "EGP" {
            return "EGP"
        }
        else {
            return "$"
        }
    }
    
    func validatePromoCode() {
        priceRulesRepo.getPriceRules().sink(
            receiveCompletion: { (completion) in
                switch completion {
                    case .finished:
                        print("Finished")
                    case .failure:
                        print("Failure")
                }
            },
            receiveValue: { (response) in
                guard let response = response.priceRules else {
                    return
                }
                self.priceRules = response
                self.validatePriceRule()
            }
        ).store(in: &cancellables)
    }
    
    func postOrder() {
        order?.subTotalPrice = String(describing: priceAfterDiscount!)
        ordersRepo.createOrder(order: order!)
            .sink(receiveCompletion: { [weak self] (completion) in
            switch completion {
            case .finished:
                print("Finished")
                self?._isOrderPlaced = true
                self?.cartItemsRepo.deleteAll(email: (self?.customerRepo.getCustomerFromUserDefaults()?.email)!)
            case .failure:
                print("Failure")
                self?._isOrderPlaced = false
            }
        }) { (response) in
            print(response.order)
        }.store(in: &cancellables)
    }
}

extension CheckoutViewModel {
    
    private func validatePriceRule() {
        for rule in priceRules! {
            if rule.title?.lowercased() == priceRule?.lowercased() {
                
                validPriceRule = rule
                calculateDiscount()
                _isValidPriceRule = true
                return
            }
        }
        _isValidPriceRule = false
        validPriceRule = nil
    }
    
    private func calculateDiscount() {
        if validPriceRule?.valueType == "fixed_amount" {
            let discountAmount = Formatter.getIntPrice(from: validPriceRule?.value ?? "0.0")
            priceAfterDiscount = Formatter.getIntPrice(from: order?.totalPrice ?? "1500.0") + discountAmount
        }
    }
}
