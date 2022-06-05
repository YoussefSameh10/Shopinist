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
import NVActivityIndicatorView

class CategoriesViewController: UIViewController{
    
    
    //MARK: -Variables
    private var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    
    private var viewModel: CategoriesViewModelProtocol!
    private var router: CategoriesRouterProtocol!
    
    private let networkManager : NetworkManagerProtocol? = nil
    
    private var observer: AnyCancellable?
    
    private var searchController: UISearchController!
    var isSearchBarEmpty: Bool {
        return searchController?.searchBar.text?.isEmpty ?? true
    }
    
    var indicator: NVActivityIndicatorView!
    
    //MARK: -Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var noProductsLabel: UILabel!
    @IBOutlet private weak var mainSegmentedControl: RESegmentedControl!
    
    //MARK: -Initializers
    init(
        nibName: String?,
        viewModel: CategoriesViewModelProtocol,
        router: CategoriesRouterProtocol = CategoriesRouter()
    ) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillLayoutSubviews() {
        hideNavBar()
    }
    
    //MARK: -Methods
    private func initView() {
        startActivityIndicator()
        showNavBar()
        setupCollectionView()
        listenForChangesInProductsList()
        setupSegmentControl()
        setupSearchController()
    }
    
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func showNavBar() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(showSearchBar))
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(navigateToFilterScreen))
        navigationItem.rightBarButtonItems = [searchButton, filterButton]
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
    
    @objc private func showSearchBar() {
        navigationItem.searchController?.searchBar.isHidden = !(navigationItem.searchController?.searchBar.isHidden)!
    }
    
    @objc private func navigateToFilterScreen() {
        router.navigateToFilterScreen(viewModel: viewModel)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.tabBarController?.tabBar.isHidden = true
        
        let itemWidth = collectionView.bounds.width/2 - 8
        let itemHeight = CGFloat(exactly: 200)!
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = 4
        collectionView.collectionViewLayout = layout
    }
    
    private func listenForChangesInProductsList() {
        observer = viewModel.searchedProductsList.sink { (productsList) in
            
            if let productsList = productsList {
                self.stopActivityIndicator()
                if(productsList.isEmpty) {
                    self.showEmptyScreen()
                }
                else {
                    self.showPopulatedScreen()
                }
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
        navigationItem.searchController?.searchBar.isHidden = true
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func filterProductsForSearchText(_ searchText: String) {
        viewModel.searchString = searchText
        viewModel.filterProducts()
        collectionView.reloadData()
    }
    
    //MARK: -Actions
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
        cell.priceLabel.text = String(Formatter.getIntPrice(from: viewModel.getProductAt(index: indexPath.row)?.variants?[0].price ?? "PRICE"))
        cell.productImageView.kf.setImage(with: URL(string: (viewModel.getProductAt(index: indexPath.row)?.images![0].src!) ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        router.navigateToProductDetailsScreen(appDelegate: appDelegate, product: viewModel.getProductAt(index: indexPath.row)!)
    }
    
}

extension CategoriesViewController {
    
    private func startActivityIndicator() {
        indicator = createActivityIndicator()
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        indicator.stopAnimating()
    }
}

extension CategoriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterProductsForSearchText(searchController.searchBar.text ?? "")
    }
}
