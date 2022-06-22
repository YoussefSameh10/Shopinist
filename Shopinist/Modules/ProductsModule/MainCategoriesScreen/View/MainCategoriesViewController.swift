//
//  MainCategoriesViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/30/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainCategoriesViewController: UIViewController {

    // MARK: -Variables
    var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    var viewModel: MainCategoriesViewModelProtocol!
    var router: MainCategoriesRouterProtocol!
    var indicator: NVActivityIndicatorView!
    
    // MARK: -Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: -Initilaizers
    init(
        nibName: String? = String(describing: MainCategoriesViewController.self),
        viewModel: MainCategoriesViewModelProtocol = MainCategoriesViewModel(),
        router: MainCategoriesRouterProtocol = MainCategoriesRouter()
    ) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manageBars()
    }
    
    // MARK: -Methods
    private func manageBars() {
        if viewModel.brandName == nil {
            navigationController?.navigationBar.isHidden = true
            tabBarController?.tabBar.isHidden = false
        }
        else {
            self.title = viewModel.brandName?.capitalized
            navigationController?.navigationBar.isHidden = false
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: -Delegates Extension
extension MainCategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib(nibName: "MainCategoryCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCategoryCell
        cell.image = viewModel.titles[indexPath.row]
        cell.name = viewModel.titles[indexPath.row].capitalized
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var category: ProductCategory!
        if(indexPath.row == 0) {
            viewModel.category = .Men
            category = .Men
        }
        else if(indexPath.row == 1) {
            viewModel.category = .Women
            category = .Women
        }
        else if(indexPath.row == 2) {
            viewModel.category = .Kids
            category = .Kids
        }
        else {
            viewModel.category = .Sales
            category = .Sales
        }
        
        router.navigateToCategoriesScreen(
            appDelegate: appDelegate,
            category: category,
            brandName: viewModel.brandName
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: collectionView.bounds.width/2 - 8, height: collectionView.bounds.height/2.5 - 8)
    }
    

}

