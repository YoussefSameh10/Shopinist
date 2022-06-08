//
//  ViewController.swift
//  Shopinist
//
//  Created by Amr El Shazly on 05/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var moreOrdersTableview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    setupMoreOrdersTableView(){
        moreOrdersTableview.delegate = self
        moreOrdersTableview.dataSource = self
        moreOrdersTableview.
    }
    

}
