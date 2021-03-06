//
//  ProductSizeCollectionViewCell.swift
//  Shopinist
//
//  Created by Amr El Shazly on 27/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class ProductSizeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var productSizeLabel: UILabel!
    
    var productSize : String = "" {
        didSet {
            productSizeLabel.text = productSize
        }
    }
    var textColor: UIColor = .black {
        didSet {
            productSizeLabel.textColor = textColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black
        selectedBackgroundView = backgroundView
    }

}
