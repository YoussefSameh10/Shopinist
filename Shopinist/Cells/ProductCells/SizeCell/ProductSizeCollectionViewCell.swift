//
//  ProductSizeCollectionViewCell.swift
//  Shopinist
//
//  Created by Amr El Shazly on 27/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class ProductSizeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var productSizeLabel: UILabel!
    
    var productSize : String  = "" {
        didSet {
            productSizeLabel.text = productSize
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
