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
    
    // 6035824017580
    //6035824017580 ?? 0
    
    func getCustomerOrdersList(){
        let customerId = customerRepo.getCustomerFromUserDefaults()?.id
        orderRepo.getOrdersOfCustomer(customerID:6035824017580 ?? 0 ).sink(receiveCompletion: { completion in
            
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
    
    func getOrdersCount() -> Int{
        return customerOrdersList?.count ?? 0
    }
    
    func getOrderAtIndex(retrievedIndex : Int) -> Order?{
        return customerOrdersList?[retrievedIndex] ?? nil
    }
    
    
    func getCustomerFromUserDefault() -> String?{
        customerEmail = customerRepo.getCustomerFromUserDefaults()?.email
        return customerEmail
    }
    
    func getCustmerNameFromUserDefaults() -> String? {
        return customerRepo.getCustomerFromUserDefaults()?.firstName
    }
    
    func logOut(){
        let customerId = customerRepo.getCustomerFromUserDefaults()?.id
        customerRepo.removeCustomerFromUserDefaults(id: customerId ?? 0)
    }
    
    func getSelectedCurrency() -> String{
        return customerRepo.getSelectedCurrency()
    }
    
    
   
    
}
