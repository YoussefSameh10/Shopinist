//
//  onBoardingCell.swift
//  Shopinist
//
//  Created by Mohammad Amr on 6/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Lottie

class onBoardingCell: UICollectionViewCell {
    @IBOutlet weak var animation: AnimationView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(_ slide : OnBoardingSlide){
        animation.contentMode = .scaleAspectFit
        animation.animation = Animation.named(slide.animation)
        animation.loopMode = .loop
        animation.animationSpeed = 0.5
        animation.play()
        
        title.text = slide.title
        desc.text = slide.desc
    }
}
