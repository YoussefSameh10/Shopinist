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
    
    // MARK: - Variables
    
    var viewModel : FavouritesViewModelProtocol!
    var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    
    // MARK: - Init
    
    init(nibName : String? , viewModel : FavouritesViewModelProtocol ){
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
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
        favouritesTableView.reloadData()
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
        cell.favItemTitle = viewModel.products![indexPath.row].title!
        cell.favItemImage = viewModel.products![indexPath.row].images![0].src!
        print("*****************")
        print(viewModel.getFavouritesFromDB()[0])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row")
        var product = viewModel.products![indexPath.row]
        let productDetailsVC = ProductDetailsViewController(
            nibName: "ProductDetailsViewController",
            viewModel: ProductDetailsViewModel(
                product:product,
                productRepo: FavouritesProductRepo.getInstance(databaseManager: FavouritesDataBaseManager.getInstance(appDelegate: appDelegate)), cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: appDelegate))
            )
        )
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            viewModel.removeFavouritesItemFromRepo(product: viewModel.getFavouritesFromDB()[indexPath.row])
            favouritesTableView.deleteRows(at: [indexPath], with: .automatic)
            favouritesTableView.reloadData()
            
//            let alert  = UIAlertController(title: "Warning", message: "Press OK To Remove This Item From Favourites", preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .destructive) { [weak self] action  in
//                self!.viewModel.removeFavouritesItemFromRepo(product: self!.viewModel.getFavouritesFromDB()[indexPath.row])
//                self!.favouritesTableView.deleteRows(at: [indexPath], with: .automatic)
//                self!.favouritesTableView.reloadData()
//            }
//            alert.addAction(action)
            
        }
        
    }
    



}
