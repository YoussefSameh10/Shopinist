//
//  UIHelper.swift
//  Shopinist
//
//  Created by Youssef on 6/5/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

func createActivityIndicator() -> NVActivityIndicatorView {
    return NVActivityIndicatorView(
        frame: CGRect(x: 0, y: 0, width: 48, height: 48),
        type: .ballTrianglePath,
        color: .black,
        padding: 0
    )
}
