//
//  AddressesViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/17/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine

class AddressesViewController: BaseViewController {

    var addressesViewModel: AddressesViewModelProtocol!
    var router: AddressesRouterProtocol!
    var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    init(
        nibName: String = "AddressesViewController",
        addressesViewModel: AddressesViewModelProtocol,
        router: AddressesRouterProtocol = AddressesRouter()
    ) {
        super.init(nibName: nibName, bundle: nil)
        self.addressesViewModel = addressesViewModel
        self.router = router
        self.router.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressesViewModel.customerAddresses
            .receive(on: DispatchQueue.main)
            .sink { (addresses) in
                self.tableView.reloadData()
            }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Delivery Address"
        navigationController?.navigationBar.isHidden = false
    }
}

extension AddressesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressesViewModel.getaddressesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "AddressCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddressCell
        cell.addressLabel.text = addressesViewModel.getCustomerAddress(retrievedIndex: indexPath.row).address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        router.navigateToCheckout(
            address: addressesViewModel.getCustomerAddress(retrievedIndex: indexPath.row),
            order: &addressesViewModel.order
        )
    }
}
