//
//  ViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/23/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var adBtn: UIButton!
    @IBOutlet weak var brandsCV: UICollectionView!
    
    //MARK:- Variables
    private var viewModel : HomeViewModel?
    private var cancellables : Set<AnyCancellable> = []
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
        initUI()
        setUpBinding()
    }
    
    
    //MARK:- Actions
    @IBAction func redirectToAdvertisment(_ sender: UIButton) {
        if let url = URL(string: "https://www.amazon.com") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func goToProductsDetails(_ sender: UIButton) {
        // let destcVC = ViewController(nibName: "MyViewController", bundle: nil)
        let destVc = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(destVc, animated: true)
    }
    
    
    //MARK:- Functions
    private func initTabBarController(){
        
        tabBarController?.tabBar.items?[0].title = "Home"
        tabBarController?.tabBar.items?[1].title = "Categories"
        tabBarController?.tabBar.items?[2].title = "Profile"
        tabBarController?.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBarController?.tabBar.items?[1].image = UIImage(systemName: "square.grid.2x2.fill")
        tabBarController?.tabBar.items?[2].image = UIImage(systemName: "person.fill")
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func initUI(){
    
        adBtn.layer.cornerRadius = 25
        adBtn.layer.masksToBounds = true
        adBtn.imageView?.contentMode = .scaleToFill
        
        initCollectionView(brandsCV, height: Float(brandsCV.bounds.height / 3), width: Float(UIScreen.main.bounds.width / 2 - 24), radius: 25, spacing:4, isHorizontal: false)
        
        initTabBarController()
        
    }
    
    private func initCollectionView(_ collectionView : UICollectionView, height: Float, width : Float, radius : Float, spacing : Float, isHorizontal : Bool){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.cornerRadius = CGFloat(exactly: radius)!
        collectionView.layer.masksToBounds = true
        
        let itemWidth  = CGFloat(width)
        let itemHeight = CGFloat(height)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = CGFloat(spacing)
        if(isHorizontal == true){
            layout.scrollDirection = .horizontal
        }
        else{
            layout.scrollDirection = .vertical
        }
        collectionView.collectionViewLayout = layout
    }
    
    private func initViewModel(){
        viewModel = HomeViewModel(productsRepo: ProductsRepo.getInstance(networkManager: NetworkManager.getInstance()))
    }
    
    private func setUpBinding(){
        viewModel?.$brands.sink { [weak self] (brand) in
            self?.brandsCV.reloadData()
        }.store(in: &cancellables)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.viewModel?.brands?.count ?? 0
        print("itemsCount: \(count)")
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "BrandsCell", bundle: nil), forCellWithReuseIdentifier: "BrandsCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCell", for: indexPath) as! BrandsCell
        cell.updateImage(name: self.viewModel?.brands?[indexPath.row] ?? "adidas")
        return cell
    }
}
