//
//  ProfileOrderTableViewCell.swift
//  Shopinist
//
//  Created by Amr El Shazly on 02/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class ProfileOrderTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var orderPriceLabel: UILabel!
    
    @IBOutlet private weak var orderCreatedAtLabel: UILabel!
    
    
    @IBOutlet weak var cellView: CornerView!
    
    // MARK: - Variables
    
    var orderPrice : String = "" {
        didSet{
            orderPriceLabel.text = orderPrice
        }
    }
    
    var orderCreatedAt : String = "" {
        didSet {
            orderCreatedAtLabel.text = orderCreatedAt
        }
    }
    

    // MARK: - LifeCycle methdos
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.gray.cgColor
        cellView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
