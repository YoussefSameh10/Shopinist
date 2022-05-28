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

extension ProductDetailsViewController {
    
    // MARK: - Collection View Functions
    
    func drawProductImageCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "productCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.productImageView.kf.setImage(with : URL(string: (viewModel.product?.images![indexPath.row].src!)!), placeholder: UIImage(named: "shoes_photo_.png"))
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
        //cell.productSizeLabel.text = viewModel.products?[0].options?[0].name?.rawValue
        cell.productSizeLabel.text = "9"
        setCellDesgin(cell)
        print("size cell  -------")
        return cell
        
    }
    
    func didSelectProductImageCell(_ indexPath: IndexPath) -> DownloadTask? {
        
        return productMainImageView.kf.setImage(with : URL(string: (viewModel.product?.images![indexPath.row].src!)!), placeholder: UIImage(named: "shoes_photo_.png"))
    }
    
}
