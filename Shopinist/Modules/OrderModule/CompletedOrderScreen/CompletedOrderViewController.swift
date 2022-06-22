//
//  CompletedOrderViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/22/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Lottie

class CompletedOrderViewController: BaseViewController {

    @IBOutlet weak var completedAnimationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        completedAnimationView.contentMode = .scaleAspectFit
        completedAnimationView.loopMode = .playOnce
        completedAnimationView.animationSpeed = 1
        completedAnimationView.play()
        
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func navigateToHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
