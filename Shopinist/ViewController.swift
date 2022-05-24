//
//  ViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/23/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBarController?.tabBar.items?[0].title = "First"
        tabBarController?.tabBar.items?[1].title = "Second"
        tabBarController?.tabBar.items?[0].image = UIImage(systemName: "pencil")
        tabBarController?.tabBar.items?[1].image = UIImage(systemName: "star")
    }

    @IBAction func buttonTapped(_ sender: Any) {
        self.navigationController?.pushViewController(
            ThirdViewController(nibName: "ThirdViewController", bundle: nil),
            animated: true
        )
    }
    
}

