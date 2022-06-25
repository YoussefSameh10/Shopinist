//
//  CartViewController.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/30/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine
import Lottie

class CartViewController: BaseViewController {

    //MARK:- Variables
    private var viewModel : CartViewModelProtocol?
    private var router : CartRouterProtocol?
    private var cancellables : Set<AnyCancellable> = []
    private var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    private var currency = "USD"
    
    //MARK:- Outlets
    @IBOutlet weak var cartTV: UITableView!
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var dataNotFoundAnim: AnimationView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var notRegisteredHolder: UIView!
    
    @IBOutlet weak var notRegisteredAnim: AnimationView!
    
    //MARK:- Life Cycle
    init(
        nibName: String? = "CartViewController",
        viewModel: CartViewModelProtocol? = CartViewModel(cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: (UIApplication.shared.delegate as! AppDelegate)))),
        router : CartRouterProtocol? = CartRouter()
    ) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router?.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.getCartItems()
        setUpBinding()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        configureUI()
        initTableView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel?.updateAll()
    }
    
    //MARK:- Actions
    @IBAction func proceedToCheckout(_ sender: UIButton) {
        let order = self.viewModel?.createOrder()
        router?.navigateToCheckout(order: order!)
    }
    
    
    //MARK:- Functions
    private func initUI(){
        checkoutBtn.layer.cornerRadius = 25
        checkoutBtn.layer.cornerRadius = 25
    }
    
    private func configureUI(){
        let count = self.viewModel?.getCartItemsCount() ?? 0
        
        let userDefaults = UserDefaults.standard
        if let currency = userDefaults.value(forKey: CURRENCY) as? String {
            self.currency = currency
        }
        
        if let _ = userDefaults.value(forKey: EMAIL) as? String{
            notRegisteredHolder.isHidden = true
            if (count == 0){
                checkoutBtn.isUserInteractionEnabled = false
                dataNotFoundAnim.isHidden = false
                dataNotFoundAnim.animationSpeed = 1
                dataNotFoundAnim.loopMode = .loop
                dataNotFoundAnim.play()
            }
            else{
                checkoutBtn.isUserInteractionEnabled = true
                dataNotFoundAnim.isHidden = true
                let total = self.viewModel?.getTotalPrice() ?? 0
                totalPrice.text = Formatter.formatPriceIntoString(price: total, currency: currency)
            }
        }
        else{
            notRegisteredHolder.isHidden = false
            notRegisteredAnim.animationSpeed = 1
            notRegisteredAnim.loopMode = .loop
            notRegisteredAnim.play()
        }
        
        
    }
    
    private func initTableView(){
        cartTV.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTVCell")
        cartTV.delegate = self
        cartTV.dataSource = self
    }
    
    private func initViewModel(){
        self.viewModel = CartViewModel(cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: (UIApplication.shared.delegate as! AppDelegate))))
    }
    
    private func setUpBinding(){
        self.viewModel?.cartProducts.sink(receiveValue: { (_) in
            self.updateUI()
            }).store(in: &cancellables)
    }
    
    private func updateUI(){
        self.cartTV.reloadData()
        self.initUI()
        self.configureUI()
    }
    
}

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getCartItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            self.viewModel?.removeItemAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateUI()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVCell", for: indexPath) as! CartTableViewCell
        if (self.viewModel?.cartProducts != nil){
            cell.configureCell(product: (self.viewModel?.getItemAt(index: indexPath.row))!)
            cell.decrementCnt = {
                self.viewModel?.decrementItemAt(index: indexPath.row)
                self.configureUI()
            }
            cell.incrementCnt = {
                self.viewModel?.incrementItemAt(index: indexPath.row)
                self.configureUI()
            }
        }
        return cell
    }
    
    
}
