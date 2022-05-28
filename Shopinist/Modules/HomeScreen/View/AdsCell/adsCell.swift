//
//  adsCell.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class adsCell: UICollectionViewCell {

    @IBOutlet weak var adImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        // Initialization code
    }
    
    private func initUI()
    {
        adImage.layer.cornerRadius = 25;
        adImage.layer.masksToBounds = true;
    }
    func getNibName() -> String{
        return "adsCell"
    }
    func getIdentifier() -> String{
        return "AdsCell"
    }
}
