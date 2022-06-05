//
//  ProfileViewModel.swift
//  Shopinist
//
//  Created by Amr El Shazly on 02/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine


class ProfileViewModel : ProfileViewModelProtocol{
    
    
    // MARK: - Variables
    private var observer : AnyCancellable?
    private var cancellables : Set<AnyCancellable> = []
    var orderRepo : OrderRepoProtocol
    @Published private var customerOrdersList : [Order]?
    var customerOrders: Published<[Order]?>.Publisher{$customerOrdersList}

   
    // MARK: - Init
    
    init(orderRepo : OrderRepoProtocol){
        self.orderRepo = orderRepo
    }
    
    // MARK: - Functions
    
    func getCustomerOrdersList(){
        orderRepo.getOrdersOfCustomer(customerID: 6232280301803).sink(receiveCompletion: { completion in
            switch completion {
            case .finished :
                print("order sink finished ")
            case .failure(let error ):
                print(error)
            }
        }, receiveValue: { [weak self ] orderResponse in
            self!.customerOrdersList = orderResponse.orders
            print(orderResponse.orders?.count)
        }).store(in: &cancellables)
    }
    
    func switchToUSD() {
        print("USD")
    }
    
    func switchToEGP() {
        print("EGP")
    }
    
    
   
    
}
