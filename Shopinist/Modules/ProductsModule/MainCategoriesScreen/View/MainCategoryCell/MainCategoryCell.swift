//
//  MainCategoryCell.swift
//  Shopinist
//
//  Created by Youssef on 5/30/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class MainCategoryCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    
    var image = "" {
        didSet {
            categoryImageView.image = UIImage(named: image)
        }
    }
    var name = "" {
        didSet {
            categoryNameLabel.text = name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 25
    }

}
