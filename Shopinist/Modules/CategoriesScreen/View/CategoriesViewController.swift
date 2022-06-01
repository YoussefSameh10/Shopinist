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
    
    var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)

    
    private var viewModel: CategoriesViewModel!
    private let networkManager : NetworkManagerProtocol? = nil
    
    private var observer: AnyCancellable?
    
    private var searchController: UISearchController!
    var isSearchBarEmpty: Bool {
        return searchController?.searchBar.text?.isEmpty ?? true
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var noProductsLabel: UILabel!
    @IBOutlet private weak var mainSegmentedControl: RESegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
        
    func initViewModel(products: [Product], category: ProductCategory) {
        viewModel = CategoriesViewModel(
            productRepo: ProductsRepo.getInstance(networkManager: NetworkManager.getInstance(), databseManager: DatabaseManager.getInstance(appDelegate: appDelegate)),
            products: products,
            category: category
        )
    }
    
    private func initView() {
        showNavBar()
        setupCollectionView()
        listenForChangesInProductsList()
        setupSegmentControl()
        setupSearchController()
    }
    
    private func showNavBar() {
        navigationController?.navigationBar.isHidden = false
        var title = ""
        if(viewModel.category == .Men) {
            title = "Men"
        }
        else if(viewModel.category == .Women) {
            title = "Women"
        }
        else if(viewModel.category == .Kids) {
            title = "Kids"
        }
        else if viewModel.category == .Sales {
            title = "Sales"
        }
        else {
            title = ""
        }
        self.title = title
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let itemWidth = collectionView.bounds.width/2 - 8
        let itemHeight = CGFloat(exactly: 300)!
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = 4
        collectionView.collectionViewLayout = layout
    }
    
    private func listenForChangesInProductsList() {
        observer = viewModel.searchedProductsList.sink { (productsList) in
            if(productsList == nil || productsList?.isEmpty ?? true) {
                self.showEmptyScreen()
            }
            else {
                self.showPopulatedScreen()            }
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
    
    private func setupSegmentControl() {
        let titles = ["All", "SHOES", "T-SHIRTS", "ACCESSORIES"]

        var segmentItems: [SegmentModel] {
            return titles.map({ SegmentModel(title: $0) })
        }
        var preset = MaterialPreset(backgroundColor: .white, tintColor: .black)
        preset.textColor = .gray
        preset.segmentBorderColor = CGColor(srgbRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        mainSegmentedControl.configure(segmentItems: segmentItems, preset: preset)
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
        viewModel.filterProductsForSearchText(searchText: searchText)
        collectionView.reloadData()
    }
    
    
    @IBAction func changeMainCategory(_ sender: Any) {
        
        if mainSegmentedControl.selectedSegmentIndex == 0 {
            viewModel.subCategory = nil
        }
        else if mainSegmentedControl.selectedSegmentIndex == 1 {
            viewModel.subCategory = .shoes
        }
        else if mainSegmentedControl.selectedSegmentIndex == 2 {
            viewModel.subCategory = .tShirts
        }
        else {
            viewModel.subCategory = .accessories
        }
        searchController.searchBar.text = ""
        filterProductsForSearchText(searchController.searchBar.text ?? "")
        if viewModel.isProductsListEmpty() {
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
        return viewModel.getProductsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoriesCollectionViewCell
        
        cell.titleLabel.text = Formatter.formatProductName(productTitle: viewModel.getProductAt(index: indexPath.row)?.title ?? "")
        cell.priceLabel.text = viewModel.getProductAt(index: indexPath.row)?.variants?[0].price ?? "PRICE"
        cell.productImageView.kf.setImage(with: URL(string: (viewModel.getProductAt(index: indexPath.row)?.images![0].src!) ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailsVC = ProductDetailsViewController(nibName: "ProductDetailsViewController", viewModel: ProductDetailsViewModel(product: viewModel.getProductAt(index: indexPath.row)!, productRepo: ProductsRepo.getInstance(networkManager: NetworkManager.getInstance(), databseManager: DatabaseManager.getInstance(appDelegate: appDelegate))))
        

        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
}

extension CategoriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterProductsForSearchText(searchController.searchBar.text ?? "")
    }
}
