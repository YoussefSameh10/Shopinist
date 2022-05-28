//
//  BrandsCell.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/28/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Kingfisher

class BrandsCell: UICollectionViewCell {

    @IBOutlet weak var brandImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }

    private func initUI(){
        brandImg.layer.cornerRadius = 25
        brandImg.layer.masksToBounds = true
    }
    func getNibName() -> String{
        return "brandsCell"
    }
    func getIdentifier() -> String{
        return "BrandsCell"
    }
    func updateImage(name: String){
        let imgName = name.filter{
            $0.isLetter
        }.lowercased()
        print(imgName)
        brandImg.image = UIImage(named: imgName)
    }
}
