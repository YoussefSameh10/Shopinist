//
//  LaunchViewController.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            if let _ = UserDefaults.standard.value(forKey: FIRSTTIME) as? String{
                let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)

                let favouritesVC = FavouritesViewController(nibName: "FavouritesViewController", viewModel: FavouritesViewModel(favouritesRepo:FavouritesProductRepo.getInstance(databaseManager: FavouritesDataBaseManager.getInstance(appDelegate: self.appDelegate)), customerRepo: CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())), router: FavouritesRouter())

                let categoriesVC = MainCategoriesViewController(nibName: "MainCategoriesViewController")
                

                let cartVC = CartViewController(nibName: "CartViewController", viewModel: CartViewModel(cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: (UIApplication.shared.delegate as! AppDelegate)))), router: CartRouter())

                let profileVC = ProfileViewController(nibName: "ProfileViewController", viewModel: ProfileViewModel(orderRepo: OrderRepo.getInstance(networkManager: NetworkManager.getInstance())), router: ProfileRouter())
                
                let catNavC = UINavigationController(rootViewController: categoriesVC)
                let profileNavcontroller = UINavigationController(rootViewController: profileVC)
                
                
                let tabBarController = UITabBarController()
                        
                tabBarController.addChild(homeVC)
                tabBarController.addChild(catNavC)
                tabBarController.addChild(favouritesVC)
                tabBarController.addChild(cartVC)
                tabBarController.addChild(profileNavcontroller)
                
                self.navigationController?.viewControllers = [tabBarController]
            }
            else{
                let onBoarding = OnBoarding()
                self.navigationController?.viewControllers = [onBoarding]
                
                
                UserDefaults.standard.setValue("True", forKey: FIRSTTIME)
            }
            
        }
    }

}
