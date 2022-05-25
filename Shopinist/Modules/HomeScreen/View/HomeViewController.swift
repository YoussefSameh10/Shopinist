//
//  ViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/23/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initTabBarController()
       
        
    }
    
    func initTabBarController(){
        
        self.view.backgroundColor = .purple

        tabBarController?.tabBar.items?[0].title = "Home"
        tabBarController?.tabBar.items?[1].title = "Categories"
        tabBarController?.tabBar.items?[2].title = "Profile"
        tabBarController?.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBarController?.tabBar.items?[1].image = UIImage(systemName: "square.grid.2x2.fill")
        tabBarController?.tabBar.items?[2].image = UIImage(systemName: "person.fill")
        
        self.navigationController?.navigationBar.isHidden = true
    }

    
}

