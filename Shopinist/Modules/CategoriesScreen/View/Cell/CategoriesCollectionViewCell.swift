//
//  CategoriesCollectionViewCell.swift
//  Shopinist
//
//  Created by Youssef on 5/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coloredRectangle: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteImageWrapper: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        coloredRectangle.layer.cornerRadius = 40
        productImageView.layer.cornerRadius = 32
        productImageView.layer.masksToBounds = true
        favoriteImageWrapper.layer.cornerRadius = favoriteImageWrapper.bounds.width/2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.pressedFavorite))
        favoriteImageWrapper.isUserInteractionEnabled = true
        favoriteImageWrapper.addGestureRecognizer(tapGesture)
    }
    
    @objc func pressedFavorite() {
        print("I AM THE FAVORITE")
    }

}
