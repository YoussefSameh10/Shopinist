//
//  CartTableViewCell.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/31/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var imgHolder: CornerView!
    @IBOutlet weak var countHolder: CornerView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func initUI(){
        imgHolder.layer.borderWidth = 0.3
        imgHolder.layer.borderColor = UIColor.darkGray.cgColor
        
        countHolder.layer.borderWidth = 0.3
        countHolder.layer.borderColor = UIColor.white.cgColor
        
        minusBtn.layer.cornerRadius = 5
        minusBtn.layer.masksToBounds = true
        
        plusBtn.layer.cornerRadius = 5
        plusBtn.layer.masksToBounds = true
    }
    
}
