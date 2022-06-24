//
//  ProductVcExtension.swift
//  Shopinist
//
//  Created by Amr El Shazly on 27/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension ProductDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func setCollectionViewDelegateAndDataSource() {
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        productSizeCollectionView.delegate = self
        productSizeCollectionView.dataSource = self
        
        productSizeCollectionView.reloadData()

    }
    
    // MARK: - CollectionV dataSource and Delegate
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.productImagesCollectionView {
            
            return (viewModel.product?.images?.count) ?? 0
            
        }else{
            return (viewModel.product?.options?[0].values!.count)!
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
            viewModel.productSize = (viewModel.product?.options![0].values![indexPath.row])!
            viewModel.productVariantId = viewModel.product?.variants?[indexPath.row].id
            (collectionView.cellForItem(at: indexPath) as! ProductSizeCollectionViewCell).textColor = .white

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        (collectionView.cellForItem(at: indexPath) as! ProductSizeCollectionViewCell).textColor = .black
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/5, height: 40)
    }
    
    
    
    // MARK: - Collection View Functions
    
    func drawProductImageCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "productCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.productImage = (viewModel.product?.images![indexPath.row].src!)!
        setCellDesgin(cell)
        return cell
        
    }
    
    fileprivate func setCellDesgin(_ cell: UICollectionViewCell) {
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 10
    }
    
    func drawProductSizeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        
        let nib = UINib(nibName: "ProductSizeCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "productSizeCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productSizeCell", for: indexPath) as! ProductSizeCollectionViewCell
        cell.productSizeLabel.text = viewModel.product?.options?[0].values![indexPath.row]
        //cell.productSize = "7"
        setCellDesgin(cell)
        print("size cell  -------")
        return cell
        
    }
    
    func didSelectProductImageCell(_ indexPath: IndexPath) -> DownloadTask? {
        
        return productMainImageView.kf.setImage(with : URL(string: (viewModel.product?.images![indexPath.row].src!)!), placeholder: UIImage(named: "shoes_photo_.png"))
    }
    
}
