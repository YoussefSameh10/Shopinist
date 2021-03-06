//
//  ProductCollectionViewCell.swift
//  Shopinist
//
//  Created by Amr El Shazly on 26/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    
    var productImage : String = "" {
        didSet{
            productImageView.kf.setImage(with : URL(string:productImage ), placeholder: UIImage(named: "shoes_photo_.png"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
