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
    @IBOutlet weak var adPageControl: UIPageControl!
    @IBOutlet weak var helloLabel: UILabel!
    
    //MARK:- Variables
    private var isThreadOn = true
    private var pageIndex : Int = -1
    private var viewModel : HomeViewModelProtocol?
    private var cancellables : Set<AnyCancellable> = []
    private var appDelegate : AppDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    
    //MARK:- LifeCycle
    /*
    init(
            nibName: String? = "HomeViewController",
        viewModel: HomeViewModelProtocol? = HomeViewModel(productsRepo: ),
            router : CartRouterProtocol? = CartRouter()
        ) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router?.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isThreadOn = true
        pageIndex = -1
        initViewModel()
        initUI()
        setUpBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isThreadOn = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        configureUI()
    }
    
    
    //MARK:- Actions
    @IBAction func redirectToAdvertisment(_ sender: UIButton) {
        if let url = URL(string: "https://www.amazon.com") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func pageValueChanged(_ sender: UIPageControl) {
        print("Current Page: \(adPageControl.currentPage)")
        pageIndex = adPageControl.currentPage
        adBtn.setImage(UIImage(named: "banner\(pageIndex + 1)"), for: .normal)
        
    }
        
    
    //MARK:- Functions
    private func initTabBarController(){
        
        
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.tintColor = UIColor.black
        tabBarController?.tabBar.items?[0].title = "Home"
        tabBarController?.tabBar.items?[1].title = "Categories"
        tabBarController?.tabBar.items?[2].title = "Cart"
        tabBarController?.tabBar.items?[3].title = "Profile"
        tabBarController?.tabBar.items?[4].title = "Favourites"
        
        
        tabBarController?.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBarController?.tabBar.items?[1].image = UIImage(systemName: "square.grid.2x2.fill")
        tabBarController?.tabBar.items?[2].image = UIImage(systemName: "cart.fill")
        tabBarController?.tabBar.items?[3].image = UIImage(systemName: "person.fill")
        tabBarController?.tabBar.items?[4].image = UIImage(systemName: "heart.fill")
        
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func changeImageAutomatically(){
        DispatchQueue.global(qos: .background).async {
            while(self.isThreadOn){
                DispatchQueue.main.async {
                    let indx = (self.pageIndex + 1) % 3
                    self.pageIndex = indx
                    self.adPageControl.currentPage = indx
                    self.adBtn.setImage(UIImage(named: "banner\(indx + 1)"), for: .normal)
                }
                sleep(5)
            }
        }
    }
    
    private func initUI(){
        changeImageAutomatically()
        
        adBtn.layer.cornerRadius = 25
        adBtn.layer.masksToBounds = true
        adBtn.imageView?.contentMode = .scaleToFill
        initCollectionView(brandsCV, height: Float(brandsCV.bounds.height / 3), width: Float(UIScreen.main.bounds.width / 2 - 24), radius: 25, spacing:4, isHorizontal: false)
        
        initTabBarController()
        
    }
    
    private func configureUI(){
        let userDefaults = UserDefaults.standard
        var helloStr = "Hello Guest,"
        if let username = userDefaults.value(forKey: NAME) as? String {
            helloStr = "Hello \(String(describing: username)),"
            print("The condition is true !!")
        }
        helloLabel.text = helloStr
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
        viewModel = HomeViewModel(productsRepo: ProductsRepo.getInstance(networkManager: NetworkManager.getInstance(),databseManager: DatabaseManager.getInstance(appDelegate: appDelegate)))
    }
    
    private func setUpBinding(){
        viewModel?.brands.sink { [weak self] (brand) in
            self?.brandsCV.reloadData()
        }.store(in: &cancellables)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.viewModel!.getBrandsCount()
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let brandName = self.viewModel?.getBrand(at: indexPath.row)
        let mainCategoriesVC = MainCategoriesViewController(viewModel: MainCategoriesViewModel(brandName: brandName))
        navigationController?.pushViewController(mainCategoriesVC, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "BrandsCell", bundle: nil), forCellWithReuseIdentifier: "BrandsCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCell", for: indexPath) as! BrandsCell
        cell.updateImage(name: self.viewModel!.getBrand(at: indexPath.row))
        return cell
    }
}
