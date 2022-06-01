//
//  CartViewController.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/30/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var applyPromoBtn: UIButton!
    @IBOutlet weak var promoHolder: CornerView!
    @IBOutlet weak var cartTV: UITableView!
    @IBOutlet weak var checkoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        cartTV.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        cartTV.delegate = self
        cartTV.dataSource = self
        
    }
    
    private func initUI(){
        checkoutBtn.layer.cornerRadius = 25
        applyPromoBtn.layer.cornerRadius = 25
        checkoutBtn.layer.cornerRadius = 25
        
        promoHolder.layer.masksToBounds = true
        promoHolder.layer.borderWidth = 0.5
        promoHolder.layer.borderColor = UIColor.gray.cgColor
    }

}

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        return cell
    }
    
    
}
