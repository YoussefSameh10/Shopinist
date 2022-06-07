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
    @IBOutlet weak var viewMoreButton: UIButton!
    
    
    // MARK: - Variables
    
    var router : ProfileRouterProtocol?
    
    var buttonFlagUSD : Bool = false
    var buttonFlagEGP : Bool = true
    var egpPrice : String?
    var usdPrice : String?
    var viewModel : ProfileViewModelProtocol?
    private var cancellables : Set<AnyCancellable> = []
    var changeCurrency : (()->())?
    
    
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
        setWelcomeLabel()
        setDelegateAndDataSourceMethods()
        viewModel?.getCustomerOrdersList()
        //self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUI()
        setWelcomeLabel()
        var selectedCurrency = viewModel?.getSelectedCurrency()
        ProfileOrdersTableView.reloadData()
        
    }
    
   
    
    // MARK: - Functions
    
    func setUI() {
        
        if viewModel?.getCustomerFromUserDefault() == nil {
            parentView.isHidden = true
        }else{
            parentView.isHidden = false
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func setWelcomeLabel(){
        profileNameLabel.text = "Welcome, \(viewModel?.getCustmerNameFromUserDefaults() ?? "Geust")"
    }
        
    
    // MARK: - Actions
    
    @IBAction func logInButton(_ sender: UIButton) {
        router?.navigateToRegitserScreen()
        //parentView.isHidden = false
    }
    
    
    @IBAction func viewMoreButton(_ sender: UIButton) {
        router?.navigateToMoreOrdersScreen()
    }
    
    
    @IBAction func navigateToSettings(_ sender: UIButton) {
        router?.navigateToSettingsScreen()
        
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
        let alert  = UIAlertController(title: "Warning", message: "Are You Sure You Want To Logout", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] action  in
            self!.viewModel?.logOut()
            self!.parentView.isHidden = true
            self!.router?.navigateToRegitserScreen()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
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
            if orderResponse?.count == 0 {
                
                self!.ProfileOrdersTableView.isHidden = true
                self!.viewMoreButton.isEnabled = false
                self!.viewMoreButton.tintColor = .clear
                
            }else{
                guard let orders = orderResponse?[indexPath.row] else { return }
                
                if self!.viewModel?.getSelectedCurrency() == SelectedCurrency.EGP.rawValue{
                    //self!.changeCurrency!()
                    cell.orderPrice = "\(orders.totalPrice!) EGP"
                    
                }else{
                    //self!.changeCurrency!()
                    cell.orderPrice = "\(orders.totalPriceUsd!) USD"
                }
                cell.orderCreatedAt = orders.createdAt ?? "No Date"
            }
        }).store(in: &cancellables)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
