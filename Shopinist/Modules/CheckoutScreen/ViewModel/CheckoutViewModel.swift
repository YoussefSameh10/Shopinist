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
    var order: Order?
    var address: Address?
    
    private var cancellables: Set<AnyCancellable> = []
    @Published private var priceRules: [PriceRule]?
    
    @Published private var _isValidPriceRule: Bool?
    var isValidPriceRule: Published<Bool?>.Publisher {$_isValidPriceRule}
    var validPriceRule: PriceRule?
    var priceAfterDiscount: Int?
    
    init(
        priceRulesRepo: PriceRulesRepoProtocol = PriceRulesRepo.getInstance(),
        ordersRepo: OrderRepoProtocol = OrderRepo.getInstance(),
        customerRepo: CustomerRepoProtocol = CustomerRepo.getInstance(),
        cartItemsManager: CartItemsManagerProtocol,
        order: Order?
    ) {
        self.priceRulesRepo = priceRulesRepo
        self.ordersRepo = ordersRepo
        self.order = order
    }
    
    func getOrderPrice() -> String {
        return (order?.totalPrice)!
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
        let items = [OrderItem(variantID: 41672049819820, quantity: 2, price: "50"), OrderItem(variantID: 41672049885356, quantity: 1, price: "70")]
        let ord = Order(customer: Customer(id: 6054746292396), orderItems: items)
        ordersRepo.createOrder(order: ord)
            .sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                print("Finished")
            case .failure:
                print("Failure")
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
