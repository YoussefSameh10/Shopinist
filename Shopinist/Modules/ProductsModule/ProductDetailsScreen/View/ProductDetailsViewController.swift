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

class ProductDetailsViewController: BaseViewController {
    
    // MARK: - Vairables
    
    
    var viewModel: ProductDetailsViewModelProtocol!
    
    // MARK: - Outlets
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productReviewsLabel: UILabel!
    
    @IBOutlet weak var favouriteButtonImage: UIButton!
    
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var productMainImageView: CornerImageView!
    @IBOutlet weak var productSizeCollectionView: UICollectionView!
    
    @IBOutlet weak var colorView: CornerView!
    @IBOutlet weak var productColorButton: UIButton!
    
    @IBOutlet weak var productDescriptionTextView: UITextView!
    
    // MARK: - Init
    
    init(nibName : String? , viewModel : ProductDetailsViewModelProtocol){
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //viewModel.getCartProducts()
        print("*****\(viewModel.isInFavourite())")
        if(viewModel.isInFavourite()){
            favouriteButtonImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favouriteButtonImage.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        setCollectionViewDelegateAndDataSource()
        setUIDesigns()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUIDesigns()
        print("*****\(viewModel.isInFavourite())")
        if(viewModel.isInFavourite()){
            favouriteButtonImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favouriteButtonImage.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: - Functions
    
    fileprivate func setUIDesigns() {
        
        self.navigationController?.navigationBar.isHidden = false
        productTitleLabel.text = viewModel.product?.title
        productDescriptionTextView.text = viewModel.product?.description
        productMainImageView.kf.setImage(with : URL(string: (viewModel.product?.images![0].src!)!), placeholder: UIImage(named: "shoes_photo_.png"))
        if viewModel.getSelectedCurrency() == SelectedCurrency.EGP.rawValue {
            productPriceLabel.text = "\(viewModel.product?.variants![0].price ?? "") EGP"
        }else{
            let price = viewModel.product?.variants![0].price ?? ""
            let priceInUsd = Formatter.convertPriceCurrency(to: .USD, price: ((price as NSString).integerValue))
            productPriceLabel.text = "\(priceInUsd) USD"
        }
       
        productColorButton.setTitle(viewModel.product?.options![1].values![0], for: .normal)
        productColorButton.layer.borderWidth = 1
        productColorButton.layer.borderColor = UIColor.gray.cgColor
        productColorButton.layer.cornerRadius = 10

    }
    
    
    // MARK: - Actions
    
    @IBAction func FavouriteButton(_ sender: Any) {
        print("added to fav")
        var isFav = viewModel.isInFavourite()
        if(!isFav){
            viewModel.addToFav()
            favouriteButtonImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    
        }else{
            viewModel.removeFavFromDb()
            favouriteButtonImage.setImage(UIImage(systemName: "heart"), for: .normal)

        }
    }
    
    @IBAction func AddToCartButton(_ sender: Any) {
        print("add to cart button")
        if viewModel.productSize == "" || viewModel.productSize == nil {
            let alert  = UIAlertController(title: "Warning", message: "You Must Choose A Size To Add To Cart ", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .destructive)
            alert.addAction(action)
            self.present(alert, animated: true)
        }else{
            viewModel.addToCart(variantID: viewModel.productVariantId ?? 0)
            //print(viewModel.productVariantId)
        }
        //viewModel.getCartProducts()
    }
    
   
    
   
    
    

    
}

