//
//  ProductDetailsViewController.swift
//  Shopinist
//
//  Created by Amr El Shazly on 26/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine
import Kingfisher

class ProductDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Vairables
    
    private var cancellables : Set<AnyCancellable> = []
    var observer : AnyCancellable?
    var viewModel: ProductDetailsViewModel! = nil
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productReviewsLabel: UILabel!
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var productMainImageView: CornerImageView!
    @IBOutlet weak var productSizeCollectionView: UICollectionView!
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var colorView: CornerView!
    @IBOutlet weak var productColorButton: UIButton!
    
    // MARK: - View did Load

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewDelegateAndDataSource()
        setUIDesigns()
        initViewModel()
        
    }
    
    // MARK: - Functions
    
    fileprivate func setCollectionViewDelegateAndDataSource() {
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        productSizeCollectionView.delegate = self
        productSizeCollectionView.dataSource = self
        
        productSizeCollectionView.reloadData()

    }
    
    fileprivate func initViewModel() {
        /*viewModel.getAllProducts()
        viewModel.$response.sink { products in
            print("products controller \(products?.products?.count)")
            self.productImagesCollectionView.reloadData()
        }.store(in: &cancellables)*/
    }
    
    fileprivate func setUIDesigns() {
        
        self.navigationController?.navigationBar.isHidden = false
        productTitleLabel.text = viewModel.product?.title
        productDescriptionLabel.text = viewModel.product?.description
        productMainImageView.kf.setImage(with : URL(string: (viewModel.product?.images![0].src!)!), placeholder: UIImage(named: "shoes_photo_.png"))
        
       //productColorButton.setTitle(viewModel.product?.options![0].name, for: .normal)
        productColorButton.setTitle("Black", for: .normal)
        productColorButton.layer.borderWidth = 1
        productColorButton.layer.borderColor = UIColor.gray.cgColor
        productColorButton.layer.cornerRadius = 10
        
       
       
        //viewModel.products?[0].options?[0].name?.rawValue
        //productTitleLabel.text = viewModel.products?[0].title!
        //productPriceLabel.text = viewModel.products?[0].variants?[0].price
    }
    
   
    // MARK: - CollectionV dataSource and Delegate
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.productImagesCollectionView {
            
            return (viewModel.product?.images?.count) ?? 0
            
        }else{
            return 8
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.productImagesCollectionView {
            return drawProductImageCell(collectionView, indexPath)
        }
        else{
            return drawProductSizeCell(collectionView, indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.productImagesCollectionView {
        
            didSelectProductImageCell(indexPath)
        }
        else
        {
            
        }
    }
    
    // MARK: - Actions
    
    @IBAction func FavouriteButton(_ sender: Any) {
        print("added to fav")
    }
    
    @IBAction func AddToCartButton(_ sender: Any) {
        print("added to cart")
    }
    
    

    
}

