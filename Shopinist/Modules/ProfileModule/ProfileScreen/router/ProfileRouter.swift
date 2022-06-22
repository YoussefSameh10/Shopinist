//
//  ProfileRouter.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

class ProfileRouter : ProfileRouterProtocol {
    
    
    var viewController: ProfileViewController?
    
    func navigateToRegitserScreen() {
        
        let regitserVC = RegisterViewController(nibName: "RegisterViewController", viewModel: RegisterViewModel(repo: CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())), router: RegisterRouter())
        
        viewController?.navigationController?.pushViewController(regitserVC, animated: true)
    }
    
    func navigateToMoreOrdersScreen() {
        print("add navigation to view more orders")
        let moreOrderScreen = MoreOrdersViewController(nibName: "MoreOrdersViewController", viewModel: ProfileViewModel())
        viewController?.navigationController?.pushViewController(moreOrderScreen, animated: true)
        viewController?.navigationController?.navigationBar.isHidden = false

    }
    
    
    func navigateToSettingsScreen(){
        print("navigateToSettingsScreen")
        let settingsVC = SettingsViewController(nibName: "SettingsViewController", viewModel: SettingsViewModel())
        //viewController?.present(settingsVC, animated: true)
        viewController?.navigationController?.pushViewController(settingsVC, animated: true)
        viewController?.navigationController?.navigationBar.isHidden = false
    }
    
    
    func navigateToOrderDetailsScreen(order : Order, index : Int) {
        let orderDetailsVC = OrderDetailsViewController(viewModel: OrderDetailsViewModel(order: order, index: index))
        
        viewController?.navigationController?.pushViewController(orderDetailsVC, animated: true)
        viewController?.navigationController?.navigationBar.isHidden = false
    }
    
}
