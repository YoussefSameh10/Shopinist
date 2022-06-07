//
//  MoreOrdersViewController.swift
//  Shopinist
//
//  Created by Amr El Shazly on 05/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine
import NVActivityIndicatorView


class MoreOrdersViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var moreOrderTableView: UITableView!
    
    // MARK: - Variables
    
    var viewModel : ProfileViewModelProtocol?
    private var cancellables : Set<AnyCancellable> = []
    var count : Int?
    var indicator: NVActivityIndicatorView!


    // MARK: Init
    
    init(nibName : String? , viewModel : ProfileViewModelProtocol){
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        startActivityIndicator()
        setupTableView()
        viewModel?.getCustomerOrdersList()
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Fucntions
    
    func setupTableView(){
        moreOrderTableView.delegate = self
        moreOrderTableView.dataSource = self
        moreOrderTableView.register(UINib(nibName: "ProfileOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "profileOrderCell")
    }
    
    private func startActivityIndicator() {
        indicator = createActivityIndicator()
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        indicator.stopAnimating()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel?.customerOrders.sink(receiveValue: { [weak self] orderResponse in
            guard let orders = orderResponse else { return }
            self!.count = orders.count
        })
        
        return count ?? 4
        //return (viewModel?.getOrdersCount())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileOrderCell", for: indexPath) as! ProfileOrderTableViewCell
        viewModel?.customerOrders.sink(receiveValue: { [weak self] orderResponse in
            guard let orders = orderResponse?[indexPath.row] else { return }
            self?.stopActivityIndicator()
            cell.orderPrice = "\(orders.totalPrice!) EGP" ?? "no price"
            cell.orderCreatedAt = orders.createdAt ?? "No Date"
        }).store(in: &cancellables)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

}
