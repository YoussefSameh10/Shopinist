//
//  OrderDetailsViewController.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/6/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var orderTV: UITableView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK:- Functions
    private func initUI(){
        
    }
    
    private func initTableView(){
        orderTV.register(UINib(nibName: "OrderDetialsCell", bundle: nil), forCellReuseIdentifier: "OrderDetialsCell")
        orderTV.delegate = self
        orderTV.dataSource = self
    }
    
    
}


extension OrderDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetialsCell") as! OrderDetialsCell
        return cell
    }
    
    
}
