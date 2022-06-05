//
//  MainCategoriesViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/30/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class MainCategoriesViewController: UIViewController {

    var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)

    var viewModel: MainCategoriesViewModelProtocol!
    var router: MainCategoriesRouterProtocol!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(
        nibName: String?,
        viewModel: MainCategoriesViewModelProtocol = MainCategoriesViewModel(
            productsRepo: ProductsRepo.getInstance(
                databseManager: DatabaseManager.getInstance(appDelegate: (UIApplication.shared.delegate as! AppDelegate))
            )
        ),
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        hideNavBar()
    }
    
    private func initViewModel() {
        viewModel = MainCategoriesViewModel(productsRepo: ProductsRepo.getInstance(networkManager: NetworkManager.getInstance(), databseManager: DatabaseManager.getInstance(appDelegate: appDelegate)))
    }
    
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let itemWidth = collectionView.bounds.width/2 - 4
        let itemHeight = collectionView.bounds.height/2 - 8
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = 4
        collectionView.collectionViewLayout = layout
    }
}

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
            products: viewModel.filteredProducts ?? [],
            category: category
        )
    }
}
