//
//  OnBoarding.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class OnBoarding: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- Variables
    var slides : [OnBoardingSlide] = []
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage 
            if currentPage == slides.count - 1{
                nextBtn.isHidden = false
                nextBtn.setTitle("Get Started", for: .normal)
            }
            else{
                nextBtn.isHidden = true
            }
            
        }
    }
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    //MARK:- Actions
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)

        let favouritesVC = FavouritesViewController(nibName: "FavouritesViewController", viewModel: FavouritesViewModel(favouritesRepo:FavouritesProductRepo.getInstance(databaseManager: FavouritesDataBaseManager.getInstance(appDelegate: appDelegate)), customerRepo: CustomerRepo.getInstance(networkManager: NetworkManager.getInstance())), router: FavouritesRouter())

        let categoriesVC = MainCategoriesViewController(nibName: "MainCategoriesViewController")
        

        let cartVC = CartViewController(nibName: "CartViewController", viewModel: CartViewModel(cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: (UIApplication.shared.delegate as! AppDelegate)))), router: CartRouter())

        let profileVC = ProfileViewController(nibName: "ProfileViewController", viewModel: ProfileViewModel(orderRepo: OrderRepo.getInstance(networkManager: NetworkManager.getInstance())), router: ProfileRouter())
        
        let catNavC = UINavigationController(rootViewController: categoriesVC)
        let profileNavcontroller = UINavigationController(rootViewController: profileVC)
        
        
        let tabBarController = UITabBarController()
                
        tabBarController.addChild(homeVC)
        tabBarController.addChild(catNavC)
        tabBarController.addChild(cartVC)

        tabBarController.addChild(profileNavcontroller)
        tabBarController.addChild(favouritesVC)
        
        self.navigationController?.viewControllers = [tabBarController]
    }

    
    //MARK:- Functions
    private func initUI(){
        self.navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "onBoardingCell", bundle: nil), forCellWithReuseIdentifier: "onBoardingCell")
        
        slides = [
            OnBoardingSlide(title: "Your Infinite Wardrobe", desc: "Discover what works best for you", animation: "discover"),
            OnBoardingSlide(title: "Easy and Safe Payment", desc: "Pay for the products you buys safely and easily", animation: "payment"),
            OnBoardingSlide(title: "Product Delivery", desc: "Your product is delivered to your home safely and securely", animation: "delivery")
        ]
    }
    
}

extension OnBoarding : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardingCell", for: indexPath) as! onBoardingCell
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        
    }
}

extension OnBoarding : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
