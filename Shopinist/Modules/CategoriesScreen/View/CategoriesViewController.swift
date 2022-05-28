//
//  SecondViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/23/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Kingfisher
import Combine
import RESegmentedControl

class CategoriesViewController: UIViewController{
    
    private var viewModel: CategoriesViewModel!
    private let networkManager : NetworkManagerProtocol? = nil
    
    private var observer: AnyCancellable?
    
    private var searchController: UISearchController!
    var isSearchBarEmpty: Bool {
        return searchController?.searchBar.text?.isEmpty ?? true
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noProductsLabel: UILabel!
    @IBOutlet weak var mainSegmentedControl: RESegmentedControl!
    @IBOutlet weak var subSegmentedControl: RESegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
        initView()
    }
    
    private func initViewModel() {
        viewModel = CategoriesViewModel(productRepo: ProductsRepo.getInstance(networkManager: NetworkManager.getInstance()))
    }
    
    private func initView() {
        setupCollectionView()
        listenForChangesInProductsList()
        setupSegmentControls()
        setupSearchController()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let itemWidth = collectionView.bounds.width/2 - 8
        let itemHeight = CGFloat(exactly: 300)!
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = 4
        //layout.minimumLineSpacing = 8
        collectionView.collectionViewLayout = layout
    }
    
    private func listenForChangesInProductsList() {
        observer = viewModel.$observableProductsList.sink { (productsList) in
            
            var list: [Product]!
            if self.isSearchBarEmpty {
                list = self.viewModel.shownProductsList ?? []
            }
            else {
                list = self.viewModel.searchedProductsList ?? []
            }
            
            if(list == nil || list?.isEmpty ?? true) {
                self.showEmptyScreen()
            }
            else {
                self.showPopulatedScreen()
            }
        }
    }
    
    private func showEmptyScreen() {
        self.collectionView.isHidden = true
        self.noProductsLabel.isHidden = false
    }
    
    private func showPopulatedScreen() {
        self.collectionView.isHidden = false
        self.noProductsLabel.isHidden = true
        self.collectionView.reloadData()
    }
    
    private func setupSegmentControls() {
        
        setupMainSegmentControl()
        setupSubSegmentControl()
    }
    
    private func setupMainSegmentControl() {
        let titles = ["MEN", "WOMEN", "KIDS", "SALES"]
        
        var segmentItems: [SegmentModel] {
            return titles.map({ SegmentModel(title: $0) })
        }
        
        var preset = MaterialPreset(backgroundColor: .white, tintColor: .black)
        preset.textColor = .gray
        preset.segmentBorderColor = CGColor(srgbRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        mainSegmentedControl.configure(segmentItems: segmentItems, preset: preset)
    }
    
    private func setupSubSegmentControl() {
        let titles = ["All", "SHOES", "T-SHIRTS", "ACCESSORIES"]
        
        var segmentItems: [SegmentModel] {
            return titles.map({ SegmentModel(title: $0) })
        }
        
        var preset = MaterialPreset(backgroundColor: .white, tintColor: .black)
        preset.segmentItemBorderColor = CGColor(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        preset.segmentBorderWidth = 0.0
        preset.segmentItemBorderWidth = 2.0
        preset.textColor = .gray
        preset.segmentItemStyle.cornerRadius = 10
        preset.segmentStyle.cornerRadius = 10
        preset.segmentSpacing = 16
        
        subSegmentedControl.configure(segmentItems: segmentItems, preset: preset)
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func filterProductsForSearchText(_ searchText: String) {
        viewModel.searchedProductsList = viewModel.shownProductsList?.filter { (product: Product) -> Bool in
            return product.title!.lowercased().contains(searchText.lowercased())
        }
        collectionView.reloadData()
    }
    
    
    @IBAction func changeMainCategory(_ sender: Any) {
        if mainSegmentedControl.selectedSegmentIndex == 0 {
            viewModel.getProductsByCategory(category: .Men)
        }
        else if mainSegmentedControl.selectedSegmentIndex == 1 {
            viewModel.getProductsByCategory(category: .Women)
        }
        else if mainSegmentedControl.selectedSegmentIndex == 2 {
            viewModel.getProductsByCategory(category: .Kids)
        }
        else {
            viewModel.getProductsByCategory(category: .Sales)
        }
        filterProductsForSearchText(searchController.searchBar.text ?? "")
    }
    
    @IBAction func changeSubCategory(_ sender: Any) {
        if subSegmentedControl.selectedSegmentIndex == 0 {
            viewModel.subCategory = nil
        }
        else if subSegmentedControl.selectedSegmentIndex == 1 {
            viewModel.subCategory = .shoes
        }
        else if subSegmentedControl.selectedSegmentIndex == 2 {
            viewModel.subCategory = .tShirts
        }
        else {
            viewModel.subCategory = .accessories
        }
        filterProductsForSearchText(searchController.searchBar.text ?? "")
        var list: [Product]!
        if self.isSearchBarEmpty {
            list = self.viewModel.shownProductsList ?? []
        }
        else {
            list = self.viewModel.searchedProductsList ?? []
        }
        if list.isEmpty ?? true {
            showEmptyScreen()
        }
        else {
            showPopulatedScreen()
            collectionView.reloadData()
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchBarEmpty {
            return viewModel.shownProductsList?.count ?? 0
        }
        else {
            return viewModel.searchedProductsList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoriesCollectionViewCell
        
        var product: Product!
        if isSearchBarEmpty {
            product = viewModel.shownProductsList?[indexPath.row]
        }
        else {
            product = viewModel.searchedProductsList?[indexPath.row]
        }
        
        cell.titleLabel.text = Formatter.formatProductName(productTitle: product.title ?? "")
        cell.priceLabel.text = product.variants?[0].price ?? "PRICE"
        cell.productImageView.kf.setImage(with: URL(string: product.images![0].src!))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var product: Product!
        if isSearchBarEmpty {
            product = viewModel.shownProductsList?[indexPath.row]
        }
        else {
            product = viewModel.searchedProductsList?[indexPath.row]
        }
        
        let productDetailsVC = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
        productDetailsVC.viewModel = ProductDetailsViewModel(product: product)
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
}

extension CategoriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterProductsForSearchText(searchController.searchBar.text ?? "")
    }
}
