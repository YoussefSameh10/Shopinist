//
//  LoginViewModel.swift
//  Shopinist
//
//  Created by Youssef on 6/1/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel: LoginViewModelProtocol {
    
    var repo: CustomerRepoProtocol!
    
    @Published var _isValidLogin: Bool?
    var isValidLogin: Published<Bool?>.Publisher {$_isValidLogin}
    
    init(repo: CustomerRepoProtocol = CustomerRepo.getInstance()) {
        self.repo = repo
    }
    
    var cancellables: Set<AnyCancellable> = []
    var customers: [Customer]?
    
    func login(email: String, password: String) {
        repo.getAllCustomers().sink(
            receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure:
                    print("Failed")
                }
            },
            receiveValue: { (response) in
                guard let customers = response.customers else {
                    self._isValidLogin = false
                    return
                }
                self.customers = customers
                self.checkForUser(email: email, password: password)
            }
        ).store(in: &cancellables)
    }
    
    private func checkForUser(email: String, password: String) {
        customers?.forEach({ customer in
            if customer.email == email
                && customer.tags == password {
                
                _isValidLogin = true
                saveCustomerInfo(customer: customer)
                return
            }
        })
        _isValidLogin = false
    }
    
    private func saveCustomerInfo(customer: Customer) {
        repo.saveCustomerToUserDefaults(customer: customer)
    }
}
