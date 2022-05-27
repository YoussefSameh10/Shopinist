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
    
    private var observer: AnyCancellable?
    
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
        viewModel = CategoriesViewModel(productRepo: ProductsRepo.getInstance())
    }
    
    private func initView() {
        setupCollectionView()
        listenForChangesInProductsList()
        setupSegmentControls()
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
            self.viewModel.productsList = productsList
            self.viewModel.shownProductsList = productsList
            if(productsList == nil) {
                self.collectionView.isHidden = true
                self.noProductsLabel.isHidden = false
            }
            else {
                self.collectionView.isHidden = false
                self.noProductsLabel.isHidden = true
                self.collectionView.reloadData()
            }
        }
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
        preset.textColor = .gray
        preset.segmentBorderColor = CGColor(srgbRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        subSegmentedControl.configure(segmentItems: segmentItems, preset: preset)
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
    }
    
    @IBAction func changeSubCategory(_ sender: Any) {
        if subSegmentedControl.selectedSegmentIndex == 0 {
        }
        else if subSegmentedControl.selectedSegmentIndex == 1 {
        }
        else if subSegmentedControl.selectedSegmentIndex == 2 {
        }
        else {
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoriesCollectionViewCell
        
        cell.titleLabel.text = Formatter.formatProductName(productTitle: viewModel.productsList![indexPath.row].title ?? "")
        cell.priceLabel.text = viewModel.productsList![indexPath.row].variants?[0].price ?? "PRICE"
        cell.productImageView.kf.setImage(with: URL(string: viewModel.productsList![indexPath.row].images![0].src!))
        
        return cell
    }
    
}

