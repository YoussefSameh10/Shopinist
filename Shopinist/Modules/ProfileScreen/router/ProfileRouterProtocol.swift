//
//  ProfileRouterProtocol.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation

protocol ProfileRouterProtocol {
    
    var viewController: ProfileViewController? {get set}
    func navigateToRegitserScreen()
    func navigateToMoreOrdersScreen()
    func navigateToSettingsScreen()
    
    
}
