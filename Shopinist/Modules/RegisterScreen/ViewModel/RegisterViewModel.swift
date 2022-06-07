//
//  RegisterViewModel.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class RegisterViewModel: RegisterViewModelProtocol {
    
    private var repo: CustomerRepoProtocol
    
    @Published var _validEmail: Bool?
    var validEmail: Published<Bool?>.Publisher {$_validEmail}
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(repo: CustomerRepoProtocol = CustomerRepo.getInstance()) {
        self.repo = repo
    }
    
    func registerCustomer(name: String, email: String, password: String, address: String) {
        

        repo.registerCustomer(customer: Customer(name: name, email: email, password: password, address: address))
            .sink(
                receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("Finish")
                    case .failure:
                        print("Failed")
                    }
                },
                receiveValue: { (response) in
                    guard let customer = response.customer else {
                        self._validEmail = false
                        return
                    }
                    self.saveCustomerInfo(customer: customer)
                    self._validEmail = true
                }
            ).store(in: &cancellables)
    }
    
    func saveCustomerInfo(customer: Customer) {
        repo.saveCustomerToUserDefaults(customer: customer)
    }
    
    func isCustomerLoggedIn() -> Bool {
        if repo.getCustomerFromUserDefaults() == nil {
            return false
        }
        return true
    }
}
