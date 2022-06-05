//
//  SettingsViewModel.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class SettingsViewModel  : SettingsViewModelProtocol{
    
    // MARK: - Variables
    
    
    private var addressRepo : AddressRepoProtocol
    private var customerRepo : CustomerSettingsRepoProtocol
    @Published private var _validAddress: Address?
    var validAddress: Published<Address?>.Publisher {$_validAddress}
    
    @Published private var _customerAddresses: [Address]?
    var customerAddresses: Published<[Address]?>.Publisher {$_customerAddresses}
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    // *********** change customer repo protocol type if failed **************
    
    init(addressRepo : AddressRepoProtocol = AddressRepo.getInstance(networkManager: NetworkManager.getInstance()) , customerRepo : CustomerSettingsRepoProtocol = CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())){
        self.addressRepo = addressRepo
        self.customerRepo = customerRepo
    }
    
    // MARK: - Functions
    
    
    func createNewAddress(address : String){
        let customerID = customerRepo.getCustomerFromUserDefaults()?.id
        addressRepo.createNewAddress(address: Address(address: address, customerID: customerID!), customerID: customerID!).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                print("address added Finish")
            case .failure:
                print("address add Failed")
            }
        },receiveValue: { (response) in
            guard let address = response.address else {return}
            self._validAddress? = address
        }).store(in: &cancellables)
    }
    
    func getCustomerAddresses(){
        let customerID = customerRepo.getCustomerFromUserDefaults()?.id
        addressRepo.getAddressesOfCustomer(customerID: customerID!).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                print(" %%%%% address retrieved Finish %%%%%")
            case .failure:
                print("%%%%% address retrieved Failed %%%%%")
            }
        },receiveValue: { [weak self] (response) in
            guard let address = response.addresses else {return}
            self!._customerAddresses? = address
        }).store(in: &cancellables)
    }
    
    func getaddressesCount() -> Int{
        return _customerAddresses?.count ?? 0
    }
    
    func updateCustomerAddress(address : String){
        let customerID = customerRepo.getCustomerFromUserDefaults()?.id
        addressRepo.updateExistingAddress(address: Address(address: address, customerID: customerID!), customerID: customerID!).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                print("address updated Finish")
            case .failure:
                print("address update Failed")
            }
        },receiveValue: { (response) in
            guard let address = response.address else {return}
            self._validAddress? = address
        }).store(in: &cancellables)
    }
    
    
    func saveSelectedCurrrency(selectedCurrency : SelectedCurrency){
        customerRepo.saveSelectedCurrency(currency: selectedCurrency)
    }
    
    func getSelectedCurrency() -> String {
        return customerRepo.getSelectedCurrency()
    }
    
    
}
