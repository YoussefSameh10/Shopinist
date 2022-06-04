//
//  FavouritesViewController.swift
//  Shopinist
//
//  Created by Amr El Shazly on 31/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    @IBOutlet weak var parentView: UIView!
    
    // MARK: - Variables
    
    var viewModel : FavouritesViewModelProtocol!
    private var router : FavouritesRouterProtocol!
    var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    
    // MARK: - Init
    
    init(nibName : String? , viewModel : FavouritesViewModelProtocol , router : FavouritesRouterProtocol ){
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableDelegateAndDataSource()
        if viewModel.getCustomerFromUserDefaults() == nil {
            parentView.isHidden = true
        }else{
            parentView.isHidden = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouritesTableView.reloadData()
    }
    
    
    // MARK: - Actions:
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        let regitserVC = RegisterViewController(nibName: "RegisterViewController", viewModel: RegisterViewModel(repo: CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())), router: RegisterRouter())
        
        self.navigationController?.pushViewController(regitserVC, animated: true)
    }
    
    
    // MARK: - Functionss
    
    func setTableDelegateAndDataSource(){
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
        favouritesTableView.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouritesCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFavouritesFromDB().count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! FavouriteTableViewCell
        cell.favItemTitle = Formatter.formatProductName(productTitle: viewModel.products![indexPath.row].title!)
        cell.favItemImage = viewModel.products![indexPath.row].images![0].src!
        print("*****************")
        print(viewModel.getFavouritesFromDB()[0])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row")
        let product = viewModel.products![indexPath.row]
        router.navigateToProductDetailsScreen(appDelegate: appDelegate, product: product)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert  = UIAlertController(title: "Warning", message: "Press OK To Remove This Item From Favourites", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(title: "OK", style: .destructive) { [weak self] action  in
                self!.viewModel.removeFavouritesItemFromRepo(product: self!.viewModel.getFavouritesFromDB()[indexPath.row])
                self!.favouritesTableView.deleteRows(at: [indexPath], with: .automatic)
                self!.favouritesTableView.reloadData()
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
            
            
        }
        
    }
    
}
