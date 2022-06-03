//
//  FavouriteTableViewCell.swift
//  Shopinist
//
//  Created by Amr El Shazly on 31/05/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var favItemImageView: UIImageView!
    @IBOutlet private weak var favItemTitleLabel: UILabel!
    @IBOutlet private weak var favItemPriceLabel: UILabel!
    @IBOutlet private weak var favItemColorLabel: UILabel!
    @IBOutlet private weak var favItemSizeLabel: UILabel!
    
    
    // MARK: - Variables
    
    var favItemImage : String = "" {
        didSet{
            favItemImageView.kf.setImage(with : URL(string:favItemImage ), placeholder: UIImage(named: "shoes_photo_.png"))
        }
    }
    
    var favItemTitle : String  = "" {
        didSet {
            favItemTitleLabel.text = favItemTitle
        }
    }
    
    var favItemPrice : String  = "" {
        didSet {
            favItemPriceLabel.text = favItemPrice
        }
    }
    
    var favItemColor : String  = "" {
        didSet {
            favItemColorLabel.text = favItemColor
        }
    }
    
    var favItemSize : String  = "" {
        didSet {
            favItemSizeLabel.text = favItemSize
        }
    }
    
    // MARK: - LifeCycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Action
    
    @IBAction func removeFavItemButton(_ sender: UIButton) {
    }
    
    
}
