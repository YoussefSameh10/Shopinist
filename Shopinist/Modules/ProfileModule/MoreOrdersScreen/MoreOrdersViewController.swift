//
//  MoreOrdersViewController.swift
//  Shopinist
//
//  Created by Amr El Shazly on 05/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine
import NVActivityIndicatorView


class MoreOrdersViewController: BaseViewController,  UITableViewDelegate, UITableViewDataSource {
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var moreOrderTableView: UITableView!
    
    // MARK: - Variables
    
    var viewModel : ProfileViewModelProtocol?
    private var cancellables : Set<AnyCancellable> = []
    var count : Int?
    var indicator: NVActivityIndicatorView!


    // MARK: Init
    
    init(nibName : String? , viewModel : ProfileViewModelProtocol){
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        startActivityIndicator()
        setupTableView()
        viewModel?.getCustomerOrdersList()
        sinkOnCustomerOrders()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getCustomerOrdersList()
        sinkOnCustomerOrders()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    
    // MARK: - Fucntions
    
    func setupTableView(){
        moreOrderTableView.delegate = self
        moreOrderTableView.dataSource = self
        moreOrderTableView.register(UINib(nibName: "ProfileOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "profileOrderCell")
    }
    
    private func startActivityIndicator() {
        indicator = createActivityIndicator()
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        indicator.stopAnimating()
    }
    
    func sinkOnCustomerOrders(){
        viewModel?.customerOrders.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure:
                    print("Failed")
                }
            }, receiveValue:{ [weak self] customerOrders in
                if customerOrders != nil{
                self?.stopActivityIndicator()
                self?.moreOrderTableView.reloadData()
                }

            }).store(in: &cancellables)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return (viewModel?.getOrdersCount())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileOrderCell", for: indexPath) as! ProfileOrderTableViewCell
        if viewModel?.getSelectedCurrency() == SelectedCurrency.EGP.rawValue{
            cell.orderPrice = "\(viewModel?.getOrderAtIndex(retrievedIndex: indexPath.row)?.totalPrice! ?? "") EGP"

        }else{
            cell.orderPrice = "\(viewModel?.getOrderAtIndex(retrievedIndex: indexPath.row)?.totalPriceUsd! ?? "") USD"
        }
        let date = viewModel?.getOrderAtIndex(retrievedIndex: indexPath.row)?.createdAt?.split(separator: "T")
        let dateStr = String(date?[0] ?? "No Date ")
        cell.orderCreatedAt = dateStr
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        //let order = viewModel!.getOrder(index: index)
        let order = viewModel?.getOrderAtIndex(retrievedIndex: index)
        
        let orderDetailsVC = OrderDetailsViewController(viewModel: OrderDetailsViewModel(order: order!, index: index))
        // print("This is the order I am printing: \(order)")
        print("I am selecting cell #\(index + 1)")
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        self.navigationController?.pushViewController(orderDetailsVC, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }

}
