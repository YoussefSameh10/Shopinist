//
//  SettingsViewController.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: -  Outlets
    
    @IBOutlet weak var addresssLabel: UILabel!
    @IBOutlet weak var addressTableview: UITableView!
    
    
    // MARK: - Variables
    var viewModel : SettingsViewModelProtocol?
    
    
    // MARK: - Init
    
    init(nibName : String? , viewModel : SettingsViewModelProtocol){
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - LifecycleMethods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    // MARK: - Fucntions
    func setupTableView(){
        addressTableview.delegate = self
        addressTableview.dataSource = self
        addressTableview.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        
    }
    
    // MARK: - Actions


}

extension SettingsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
        
        cell.cellAddress = "mokattam"
        cell.addressTextField.isEnabled = false
    
        cell.updateAddress = {
            print("update add button")
        }
        
        print("*****************")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
}
