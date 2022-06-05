//
//  ThirdViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/23/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    
    // MARK: - Outlets
        
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var ProfileOrdersTableView: UITableView!
    @IBOutlet weak var USDButton: UIButton!
    @IBOutlet weak var EGPButton: UIButton!
    
    @IBOutlet weak var logOutButton: UIButton!
    // MARK: - Variables
    var buttonFlagUSD : Bool = false
    var buttonFlagEGP : Bool = true
    var viewModel : ProfileViewModelProtocol?
    private var observer: AnyCancellable?
    private var cancellables : Set<AnyCancellable> = []


    // MARK: - Init
    
    init(nibName : String? , viewModel : ProfileViewModelProtocol){
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegateAndDataSourceMethods()
        viewModel?.getCustomerOrdersList()
    }
   
    // MARK: - Functions
    
    func setButtonsBackgoroundColor(){
        
        EGPButton.layer.cornerRadius = 25
        USDButton.layer.cornerRadius = 25
        logOutButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 22)
        
        if buttonFlagEGP {
            EGPButton.backgroundColor = .gray
            //EGPButton.titleLabel?.textColor = .white
            USDButton.backgroundColor = .white

        }
        else if buttonFlagUSD {
            EGPButton.backgroundColor = .white
            USDButton.backgroundColor = .gray
            //USDButton.titleLabel?.textColor = .white

            
        }
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func USDButton(_ sender: UIButton) {
        buttonFlagUSD = true ; buttonFlagEGP = false
        setButtonsBackgoroundColor()
        
    }
    
    @IBAction func EGPButton(_ sender: UIButton) {
        buttonFlagUSD = false ; buttonFlagEGP = true
        setButtonsBackgoroundColor()
    }
    
    
    @IBAction func viewMoreButton(_ sender: UIButton) {
        
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
    }
    
    
}

extension ProfileViewController :  UITableViewDelegate, UITableViewDataSource {
    
    func setDelegateAndDataSourceMethods(){
        ProfileOrdersTableView.delegate = self
        ProfileOrdersTableView.dataSource = self
        ProfileOrdersTableView.register(UINib(nibName: "ProfileOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "profileOrderCell")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileOrderCell", for: indexPath) as! ProfileOrderTableViewCell
        cell.orderPrice = "222 EGP test"
        cell.orderCreatedAt = "02/02/2020 test "
        
        viewModel?.customerOrders.sink(receiveValue: { [weak self] orderResponse in
            guard let orders = orderResponse?[indexPath.row] else { return }
            if self!.buttonFlagEGP {
                cell.orderPrice = "\(orders.totalPrice!) EGP" ?? "no price"
                //self!.ProfileOrdersTableView.reloadData()
            }else{
                cell.orderPrice = "\(orders.totalPriceUsd!) USD" ?? "no price"
                //self!.ProfileOrdersTableView.reloadData()
            }
            cell.orderCreatedAt = orders.createdAt ?? "No Date"
        }).store(in: &cancellables)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
