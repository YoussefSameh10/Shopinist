//
//  ProfileViewModel.swift
//  Shopinist
//
//  Created by Amr El Shazly on 02/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation


class ProfileViewModel : ProfileViewModelProtocol{
    
    var orderRepo : OrderRepoProtocol
    
    init(orderRepo : OrderRepoProtocol){
        self.orderRepo = orderRepo
    }
    
}
