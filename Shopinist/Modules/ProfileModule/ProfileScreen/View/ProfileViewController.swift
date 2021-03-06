//
//  ThirdViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/23/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine
import NVActivityIndicatorView
import Lottie

class ProfileViewController: BaseViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var ProfileOrdersTableView: UITableView!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var noOrderAnimationView: AnimationView!
    
    @IBOutlet weak var notLoggedInAnimationView: AnimationView!
    // MARK: - Variables
    
    var router : ProfileRouterProtocol?
    var egpPrice : String?
    var usdPrice : String?
    var viewModel : ProfileViewModelProtocol?
    private var cancellables : Set<AnyCancellable> = []
    var indicator: NVActivityIndicatorView!
        
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
        
        startActivityIndicator()
        //ProfileOrdersTableView.isHidden = true
        noOrderAnimationView.isHidden = true
        //setUI()
        //setWelcomeLabel()
        setDelegateAndDataSourceMethods()
        
        sinkOnCustomerOrders()

        //self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
        setWelcomeLabel()
        viewModel?.getCustomerOrdersList()
        var selectedCurrency = viewModel?.getSelectedCurrency()
        ProfileOrdersTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    
    // MARK: - Functions
    
    func setUI() {
        
        if viewModel?.getCustomerFromUserDefault() == nil {
            parentView.isHidden = true
            stopActivityIndicator()
            startNotLoggedInAnimation()
        }else{
            parentView.isHidden = false
        }
        self.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        
    }
    
    func setWelcomeLabel(){
        profileNameLabel.text = "Hello, \(viewModel?.getCustmerNameFromUserDefaults() ?? "Geust")"
    }
    
    func initViewMoreButton(){
        if viewModel?.getOrdersCount() ?? 0 < 2 {
            disableViewMoreButton()
        }
    }
    
    func disableViewMoreButton(){
        viewMoreButton.isEnabled = false
        viewMoreButton.tintColor = .clear
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
    
    func startNoOrdersAnimation(){
        noOrderAnimationView.contentMode = .scaleAspectFit
        noOrderAnimationView.loopMode = .loop
        noOrderAnimationView.animationSpeed = 0.5
        noOrderAnimationView.play()
    }
    
    func startNotLoggedInAnimation(){
        notLoggedInAnimationView.contentMode = .scaleAspectFit
        notLoggedInAnimationView.loopMode = .loop
        notLoggedInAnimationView.animationSpeed = 0.5
        notLoggedInAnimationView.play()
    }
        
    func sinkOnCustomerOrders(){
        viewModel?.customerOrders.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure:
                    print("Failed")
                }
            }, receiveValue:{ [weak self] customerOrders in
                if customerOrders != nil{
                    self?.stopActivityIndicator()
                    self?.noOrderAnimationView.isHidden = true
                    self?.ProfileOrdersTableView.isHidden = false
                    self?.ProfileOrdersTableView.reloadData()
                    print("**** \(customerOrders?.count)")
                }

            }).store(in: &cancellables)
    }
    
    
    // MARK: - Actions
    
    @IBAction func logInButton(_ sender: UIButton) {
        router?.navigateToRegitserScreen()
        print("login pressed")
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
        if viewModel?.getOrdersCount() == 0 {
            noOrderAnimationView.isHidden = false
            ProfileOrdersTableView.isHidden = true
            viewMoreButton.isHidden = true
            startNoOrdersAnimation()
            stopActivityIndicator()
            return 0
        }else if viewModel?.getOrdersCount() == 1{
            ProfileOrdersTableView.isHidden = false
            viewMoreButton.isHidden = true
            return 1
        }else if viewModel?.getOrdersCount() == 2{
            ProfileOrdersTableView.isHidden = false
            viewMoreButton.isHidden = true
            return 2
        }else{
            ProfileOrdersTableView.isHidden = false
            viewMoreButton.isHidden = false
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileOrderCell", for: indexPath) as! ProfileOrderTableViewCell
        
   
        if viewModel?.getSelectedCurrency() == SelectedCurrency.EGP.rawValue{
            cell.orderPrice = "\(viewModel?.getOrderAtIndex(retrievedIndex: indexPath.row)?.subTotalPrice! ?? "") EGP"

        }else{
            cell.orderPrice = "\(Formatter.getPriceInDollars(egpPrice: (viewModel?.getOrderAtIndex(retrievedIndex: indexPath.row)?.subTotalPrice! ?? ""))) USD"
        }
       
        let date = viewModel?.getOrderAtIndex(retrievedIndex: indexPath.row)?.createdAt?.split(separator: "T")
        let dateStr = String(date?[0] ?? "No Date ")
        cell.orderCreatedAt = dateStr

          
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        //let order = viewModel!.getOrder(index: index)
        let order = viewModel?.getOrderAtIndex(retrievedIndex: index)
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        router?.navigateToOrderDetailsScreen(order: order!, index: index)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
