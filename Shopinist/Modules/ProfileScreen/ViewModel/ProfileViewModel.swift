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
    var customerRepo : CustomerRepoProtocol
    @Published private var customerOrdersList : [Order]?
    var customerOrders: Published<[Order]?>.Publisher{$customerOrdersList}
    
    var customerEmail : String?

   
    // MARK: - Init
    
    init(orderRepo : OrderRepoProtocol = OrderRepo.getInstance(networkManager: NetworkManager.getInstance()) , customerRepo : CustomerRepoProtocol = CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())){
        self.orderRepo = orderRepo
        self.customerRepo = customerRepo
    }
    
    // MARK: - Functions
    
    func getCustomerOrdersList(){
        let customerId = customerRepo.getCustomerFromUserDefaults()?.id
        orderRepo.getOrdersOfCustomer(customerID: customerId ?? 6232280301803).sink(receiveCompletion: { completion in
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
    
    func getCustomerFromUserDefault(){
        customerEmail = customerRepo.getCustomerFromUserDefaults()?.email
    }
    
    func getSelectedCurrency() -> String{
        return customerRepo.getSelectedCurrency()
    }
    
    
   
    
}
