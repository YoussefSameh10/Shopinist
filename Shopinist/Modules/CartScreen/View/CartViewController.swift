//
//  CartViewController.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/30/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine

class CartViewController: UIViewController {

    //MARK:- Variables
    private var viewModel : CartViewModelProtocol?
    private var cancellables : Set<AnyCancellable> = []
    private var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    
    //MARK:- Outlets
    @IBOutlet weak var applyPromoBtn: UIButton!
    @IBOutlet weak var promoHolder: CornerView!
    @IBOutlet weak var cartTV: UITableView!
    @IBOutlet weak var checkoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
        setUpBinding()
        initTableView()
        
    }
    
    private func initUI(){
        checkoutBtn.layer.cornerRadius = 25
        applyPromoBtn.layer.cornerRadius = 25
        checkoutBtn.layer.cornerRadius = 25
        
        promoHolder.layer.masksToBounds = true
        promoHolder.layer.borderWidth = 0.5
        promoHolder.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func initTableView(){
        cartTV.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTVCell")
        cartTV.delegate = self
        cartTV.dataSource = self
    }
    
    private func initViewModel(){
        self.viewModel = CartViewModel(cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: appDelegate)))
    }
    
    private func setUpBinding(){
        self.viewModel?.cartProducts.sink(receiveValue: { (_) in
            self.cartTV.reloadData()
            }).store(in: &cancellables)
    }
    
}

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getCartItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVCell", for: indexPath) as! CartTableViewCell
        if (self.viewModel?.cartProducts != nil){
            cell.configureCell(product: (self.viewModel?.getItemAt(index: indexPath.row))!)
            cell.decrementCnt = {
                self.viewModel?.decrementItemAt(index: indexPath.row)
            }
            cell.incrementCnt = {
                self.viewModel?.incrementItemAt(index: indexPath.row)
            }
        }
        return cell
    }
    
    
}
