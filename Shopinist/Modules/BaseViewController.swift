//
//  BaseViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/22/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(displayNetworkAlert), name: Notification.Name.init(rawValue: "DisconnectedFromNetwork"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(hideNetworkAlert), name: Notification.Name.init(rawValue: "ConnectedToNetwork"), object: nil)
    }

    

    @objc func hideNetworkAlert(){
        self.navigationController?.popViewController(animated: true)
    }

    @objc func displayNetworkAlert(){
        let noNetworkVC = NoNetworkViewController()
        self.navigationController?.pushViewController(noNetworkVC, animated: true)
    }
}
