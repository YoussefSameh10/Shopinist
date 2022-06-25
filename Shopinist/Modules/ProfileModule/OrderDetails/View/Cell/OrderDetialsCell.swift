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
    
    private var currency = ""
    
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
        
        self.currency = UserDefaults.standard.value(forKey: CURRENCY) as? String ?? "EGP"
        let res = Formatter.formatPriceIntoString(price: Double(orderItem.price ?? "0")!, currency: currency)
        
        self.itemPrice.text = res
    }
    
}
