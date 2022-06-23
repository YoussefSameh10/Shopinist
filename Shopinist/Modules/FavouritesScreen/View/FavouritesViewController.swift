//
//  FavouritesViewController.swift
//  Shopinist
//
//  Created by Amr El Shazly on 31/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Lottie

class FavouritesViewController: BaseViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var favouritesTableView: UITableView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var notLogedInLabel: UILabel!
    @IBOutlet weak var noFavouritesLabel: UILabel!
    @IBOutlet weak var navigateToRegisterButton: UIButton!
    @IBOutlet weak var notFavouritesAnimationView: AnimationView!
    
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if viewModel.getCustomerFromUserDefaults() == nil {
            showNotLogedInScreen()
        }else{
            showNoFavouritesScreen()
        }
        favouritesTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Fucntions
    
    func showNotLogedInScreen(){
        parentView.isHidden = true
        noFavouritesLabel.isHidden = true
        startViewAnimation()
        notLogedInLabel.isHidden = false
        navigateToRegisterButton.isHidden = false
    }
    
    func showNoFavouritesScreen(){
        parentView.isHidden = false
        isThereFavourites()
    }
    
    func isThereFavourites(){
        if viewModel.getFavouritesFromDB().isEmpty {
            parentView.isHidden = true
            notLogedInLabel.isHidden = true
            navigateToRegisterButton.isHidden = true
            noFavouritesLabel.isHidden = false
            startViewAnimation()
        }
    }
    
    func startViewAnimation(){
        notFavouritesAnimationView.contentMode = .scaleAspectFit
        notFavouritesAnimationView.loopMode = .loop
        notFavouritesAnimationView.animationSpeed = 0.5
        notFavouritesAnimationView.play()
    }
    
    
    
    // MARK: - Actions:
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        router.navigateToRegisterScreen()

    }
            
}

// MARK: - Table View Delegate And DS


extension FavouritesViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.products![indexPath.row]
        router.navigateToProductDetailsScreen(appDelegate: appDelegate, product: product)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert  = UIAlertController(title: "Warning", message: "Press OK To Remove This Item From Favourites", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(title: "OK", style: .destructive) { [weak self] action  in
                self?.viewModel.removeFavouritesItemFromRepo(product: self!.viewModel.getFavouritesFromDB()[indexPath.row])
                self?.favouritesTableView.deleteRows(at: [indexPath], with: .automatic)
                self?.favouritesTableView.reloadData()
                self?.isThereFavourites()
                
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
            
            
        }
        
    }
    
}
