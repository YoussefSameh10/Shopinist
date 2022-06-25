//
//  OrderDetailsViewController.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/6/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class OrderDetailsViewController: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var orderTV: UITableView!
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    //MARK:- Variables
    var viewModel : OrderDetailsViewModelProtocol!
    var currency = ""
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    init(
        nibName: String? = "OrderDetailsViewController",
        viewModel: OrderDetailsViewModelProtocol
    ) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK:- Functions
    private func initUI(){
        orderNo.text = "Order #\(self.viewModel.getOrderIndex())"
        orderID.text = "Order ID: \(self.viewModel.getOrderId())"
        
        currency = UserDefaults.standard.value(forKey: CURRENCY) as? String ?? "EGP"
        let res = Formatter.formatPriceIntoString(price: Double(self.viewModel.getTotalPrice())!, currency: currency)
        totalPrice.text = "Total Price: \(res)"
    }
    
    private func initTableView(){
        orderTV.register(UINib(nibName: "OrderDetialsCell", bundle: nil), forCellReuseIdentifier: "OrderDetialsCell")
        orderTV.delegate = self
        orderTV.dataSource = self
    }
    
}


extension OrderDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetialsCell") as! OrderDetialsCell
        let item = self.viewModel.getOrderItem(at: indexPath.row)
        cell.configureCell(orderItem: item, currency: self.viewModel.getCurrency())
        return cell
    }
    
    
}
