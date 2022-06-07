//
//  AddressTableViewCell.swift
//  Shopinist
//
//  Created by Amr El Shazly on 05/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var addressTextField: UITextField!
    
    
    // MARK: - Variables
    
    var cellAddress : String = "" {
        didSet {
            addressTextField.text = cellAddress
        }
    }
    
    var updateAddress : (() -> ())?
    
    // MARK: - LifeCycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func updateAddressButton(_ sender: UIButton) {
        updateAddress?()
        
    }
    
}
