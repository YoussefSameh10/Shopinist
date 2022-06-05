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
        
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var ProfileOrdersTableView: UITableView!
    @IBOutlet weak var USDButton: UIButton!
    @IBOutlet weak var EGPButton: UIButton!
    @IBOutlet weak var viewMoreButton: UIButton!
    
    
    // MARK: - Variables
    
    var router : ProfileRouterProtocol?
    
    var buttonFlagUSD : Bool = false
    var buttonFlagEGP : Bool = true
    var egpPrice : String?
    var usdPrice : String?
    var viewModel : ProfileViewModelProtocol?
    private var cancellables : Set<AnyCancellable> = []


    // MARK: - Init
    
    init(nibName : String? , viewModel : ProfileViewModelProtocol , router : ProfileRouterProtocol){
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router?.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setDelegateAndDataSourceMethods()
        viewModel?.getCustomerOrdersList()
        
        
    }
   
    // MARK: - Functions
    
    func setUI() {
        if viewModel?.customerEmail == nil {
            //parentView.isHidden = true
        }
        self.navigationController?.navigationBar.isHidden = true

    }
    
    func setButtonsBackgoroundColor(){
        
        EGPButton.layer.cornerRadius = 25
        USDButton.layer.cornerRadius = 25
        
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
    
    @IBAction func logInButton(_ sender: UIButton) {
        router?.navigateToRegitserScreen()
    }
    @IBAction func USDButton(_ sender: UIButton) {
        buttonFlagUSD = true ; buttonFlagEGP = false
        setButtonsBackgoroundColor()
        ProfileOrdersTableView.reloadData()
    }
    
    @IBAction func EGPButton(_ sender: UIButton) {
        buttonFlagUSD = false ; buttonFlagEGP = true
        setButtonsBackgoroundColor()
        ProfileOrdersTableView.reloadData()
    }
    
    
    @IBAction func viewMoreButton(_ sender: UIButton) {
        router?.navigateToMoreOrdersScreen()
    }
    
    
    @IBAction func navigateToSettings(_ sender: UIButton) {
        router?.navigateToSettingsScreen()
        
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
        viewModel?.customerOrders.sink(receiveValue: { [weak self] orderResponse in
            guard let orders = orderResponse?[indexPath.row] else { return }
            
            // **** check currency in user defaults and set currency flag ****
            if orderResponse?.count == 0  {
                self!.ProfileOrdersTableView.isHidden = true
                self!.viewMoreButton.isEnabled = false
                self!.viewMoreButton.tintColor = .clear
            }
            if self!.buttonFlagEGP {
                cell.orderPrice = "\(orders.totalPrice!) EGP" ?? "no price"
            }else{
                cell.orderPrice = "\(orders.totalPriceUsd!) USD" ?? "no price"
            }
            cell.orderCreatedAt = orders.createdAt ?? "No Date"
        }).store(in: &cancellables)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
