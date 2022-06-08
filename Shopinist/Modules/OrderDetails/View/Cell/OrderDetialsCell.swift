//
//  OrderDetialsCell.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/6/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class OrderDetialsCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK:- Functions
    func configureCell(orderItem : OrderItem, currency : String){
        self.itemName.text  = Formatter.formatProductName(productTitle: orderItem.title!)
        self.itemQty.text   = "x \(orderItem.quantity!)"
        self.itemPrice.text = "\(orderItem.price ?? "0") \(currency)"
    }
    
}
