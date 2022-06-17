//
//  AddressesViewModel.swift
//  Shopinist
//
//  Created by Youssef on 6/17/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class AddressesViewModel: AddressesViewModelProtocol {
    
    private var addressRepo : AddressRepoProtocol
    private var customerRepo : CustomerSettingsRepoProtocol
    
    @Published private var _customerAddresses: [Address]?
    var customerAddresses: Published<[Address]?>.Publisher {$_customerAddresses}
    
    private var cancellables: Set<AnyCancellable> = []
    
    var order: Order!
    
    init(
        addressRepo : AddressRepoProtocol = AddressRepo.getInstance(
            networkManager: NetworkManager.getInstance()
        ),
        customerRepo : CustomerSettingsRepoProtocol = CustomerRepo.getInstance(
            networkManager: NetworkManager.getInstance()
        ),
        order: Order
    ) {
        self.addressRepo = addressRepo
        self.customerRepo = customerRepo
        self.order = order
        getCustomerAddresses()
    }
    
    func getCustomerAddresses(){
        let customerID = customerRepo.getCustomerFromUserDefaults()?.id
        print(customerID)
        addressRepo.getAddressesOfCustomer(customerID: customerID!).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                print(" %%%%% address retrieved Finish %%%%%")
            case .failure:
                print("%%%%% address retrieved Failed %%%%%")
            }
        },receiveValue: { (response) in
            guard let addresses = response.addresses else {return}
            self._customerAddresses = addresses
        }).store(in: &cancellables)
    }
    
    func getaddressesCount() -> Int{
        print(_customerAddresses?.count)
        return _customerAddresses?.count ?? 0
    }
    
    func getCustomerAddress(retrievedIndex : Int) -> Address{
        return _customerAddresses![retrievedIndex]
    }
    
}
