//
//  CartTableViewCell.swift
//  Shopinist
//
//  Created by Mohamed AMR on 5/31/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Kingfisher

class CartTableViewCell: UITableViewCell {
    //MARK:- Variables
    private var cnt : Int = 1
    private var currency = "USD"
    var decrementCnt : (() -> ())?
    var incrementCnt : (() -> ())?
    
    //MARK:- Outlets
    @IBOutlet weak var imgHolder: CornerView!
    @IBOutlet weak var countHolder: CornerView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var size: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        let userDefaults = UserDefaults.standard
        if let currency = userDefaults.value(forKey: CURRENCY) as? String {
            self.currency = currency
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK:- Actions
    @IBAction func decrement(_ sender: UIButton) {
        if (cnt > 1){
            cnt = cnt - 1
            countLabel.text = "\(cnt)"
            decrementCnt?()
        }
    }
    
    @IBAction func increment(_ sender: UIButton) {
        cnt = cnt + 1
        countLabel.text = "\(cnt)"
        incrementCnt?()
    }
    //MARK:- Functions
    private func initUI(){
        imgHolder.layer.borderWidth = 0.3
        imgHolder.layer.borderColor = UIColor.darkGray.cgColor
        
        countHolder.layer.cornerRadius = 10
        countHolder.layer.borderWidth = 0.5
        countHolder.layer.borderColor = UIColor.white.cgColor
        
        minusBtn.layer.cornerRadius = 5
        minusBtn.layer.masksToBounds = true
        
        plusBtn.layer.cornerRadius = 5
        plusBtn.layer.masksToBounds = true
    }
    
    func configureCell(product: CartProduct){
        img.kf.setImage(with: URL(string: product.image!))
        cnt = Int(product.count)
        countLabel.text = "\(cnt)"
        name.text = Formatter.formatProductName(productTitle: product.title!)
        price.text = "\(String(describing: product.price!)) \(currency)"
        color.text = product.color!.capitalized
        size.text = "Size: \(product.size!)"
    }
    
}
