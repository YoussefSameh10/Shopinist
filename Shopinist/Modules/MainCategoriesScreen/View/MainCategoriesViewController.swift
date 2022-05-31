//
//  MainCategoriesViewController.swift
//  Shopinist
//
//  Created by Youssef on 5/30/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class MainCategoriesViewController: UIViewController  {

    let images = [
        "men",
        "women",
        "kids",
        "sales"
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
        setupCollectionView()
    }
    
    private func hideNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let itemWidth = collectionView.bounds.width/2 - 4
        let itemHeight = collectionView.bounds.height/5 - 8
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
        cell.image = images[indexPath.row]
        cell.name = images[indexPath.row].capitalized
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoriesVC = CategoriesViewController(nibName: "CategoriesViewController", bundle: nil)
        if(indexPath.row == 0) {
            categoriesVC.initViewModel(category: .Men)
        }
        else if(indexPath.row == 1) {
            categoriesVC.initViewModel(category: .Women)
        }
        else if(indexPath.row == 2) {
            categoriesVC.initViewModel(category: .Kids)
        }
        else {
            categoriesVC.initViewModel(category: .Sales)
        }
        
        self.navigationController?.pushViewController(categoriesVC, animated: true)
        
    }
}
