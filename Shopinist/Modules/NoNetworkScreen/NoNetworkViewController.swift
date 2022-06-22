//
//  NoNetworkViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/22/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Lottie

class NoNetworkViewController: BaseViewController {

    @IBOutlet weak var noNetworkAnimationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        noNetworkAnimationView.contentMode = .scaleAspectFit
        noNetworkAnimationView.loopMode = .loop
        noNetworkAnimationView.animationSpeed = 1
        noNetworkAnimationView.play()

        navigationController?.navigationBar.isHidden = true
    }
}
