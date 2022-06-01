//
//  CartCell.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/30/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var sizelabel: UILabel!
    @IBOutlet weak var itemImgHolder: UIView!
    @IBOutlet weak var dataHolder: UIView!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //initUI()
    }

    private func initUI(){
        itemImgHolder.layer.borderWidth = 0.1
        itemImgHolder.layer.borderColor = UIColor.black.cgColor
        
        colorView.layer.cornerRadius = 15
        colorView.layer.masksToBounds = true
        colorView.layer.borderWidth  = 0.1
        colorView.layer.borderColor = UIColor.white.cgColor
        
        minusBtn.layer.cornerRadius  = 10
        plusBtn.layer.cornerRadius   = 10
        
        itemName.text = "Luxury Shoe"
    }
    
    override func layoutSubviews() {
       // initUI()
    }
    
    func setItemImage(url: String){
        
    }
    
}
