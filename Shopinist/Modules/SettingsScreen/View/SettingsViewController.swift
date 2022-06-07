//
//  SettingsViewController.swift
//  Shopinist
//
//  Created by Amr El Shazly on 04/06/2022.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine

class SettingsViewController: UIViewController {
    
    // MARK: -  Outlets
    
    @IBOutlet weak var newAddressTextField: UITextField!
    @IBOutlet weak var addresssLabel: UILabel!
    @IBOutlet weak var addressTableview: UITableView!
    @IBOutlet weak var USDButton: UIButton!
    @IBOutlet weak var EGPButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    // MARK: - Variables
    var viewModel : SettingsViewModelProtocol?
    var buttonFlagUSD : Bool = false
    var buttonFlagEGP : Bool = true
    private var cancellables : Set<AnyCancellable> = []

    
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
        viewModel?.getCustomerAddresses()
        sinkOnAddressObserver()
        setupButtonsInWillAppear()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupButtonsInWillAppear()
    }
    
    
    
    // MARK: - Fucntions
    
    func sinkOnAddressObserver(){
        viewModel?.customerAddresses.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] addresses in
            //if addresses != nil{
                self?.addressTableview.reloadData()
            //}
                
            }).store(in: &cancellables)
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func setupTableView(){
        addressTableview.delegate = self
        addressTableview.dataSource = self
        addressTableview.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        
    }
    
    func setButtonsBackgoroundColor(){
        setButtonsRadius()
        if buttonFlagEGP {
           setEgpButtonColors()
        }
        else if buttonFlagUSD {
            setUSdButtonColors()
        }
        
    }
    
    func setupButtonsInWillAppear(){
        
        let seletcedCurrency = viewModel?.getSelectedCurrency()
        print("xxxxxxx \(seletcedCurrency) xxxxxx")
        setButtonsRadius()
        if seletcedCurrency == SelectedCurrency.EGP.rawValue {
            setEgpButtonColors()
        }else{
            setUSdButtonColors()
        }
        if newAddressTextField.text?.isEmpty == true {
            disableSaveButton()
        }
    }
    
    
    
    func setEgpButtonColors(){
        setButtonsRadius()
        EGPButton.backgroundColor = .gray
        USDButton.backgroundColor = .white

        EGPButton.setTitleColor(.black, for: .normal)
        USDButton.setTitleColor(.black, for: .normal)
    }
    
    func setUSdButtonColors(){
        setButtonsRadius()
        EGPButton.backgroundColor = .white
        USDButton.backgroundColor = .gray

        EGPButton.setTitleColor(.black, for: .normal)
        USDButton.setTitleColor(.black, for: .normal)
    }
    
    func setButtonsRadius(){
        EGPButton.layer.cornerRadius = 25
        USDButton.layer.cornerRadius = 25
        EGPButton.layer.borderWidth = 1
        USDButton.layer.borderWidth = 1
        EGPButton.layer.borderColor = UIColor.black.cgColor
        USDButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func enableSaveButton(){
        saveButton.isEnabled = true
        saveButton.backgroundColor = .black
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 25
    }
    
    func disableSaveButton(){
        saveButton.isEnabled = false
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.cornerRadius = 25
        saveButton.layer.borderColor = UIColor.black.cgColor
        saveButton.layer.borderWidth = 1
    }
    
    // MARK: - Actions
    
    @IBAction func saveNewAddButton(_ sender: UIButton) {
        
        let newAddres = newAddressTextField.text
        viewModel?.createNewAddress(address: newAddres!)
        
        
    }
    
    @IBAction func selectUSDButton(_ sender: UIButton) {
        
        buttonFlagUSD = true ; buttonFlagEGP = false
        setButtonsBackgoroundColor()
        viewModel?.saveSelectedCurrrency(selectedCurrency: .USD)
    }
    
    @IBAction func selectEGPButton(_ sender: UIButton) {
        
        buttonFlagUSD = false ; buttonFlagEGP = true
        setButtonsBackgoroundColor()
        viewModel?.saveSelectedCurrrency(selectedCurrency: .EGP)
        
    }
    
    @IBAction func newAddressTFChanged(_ sender: UITextField) {
        
        if (newAddressTextField.text?.isEmpty) == false {
            enableSaveButton()
        }else{
            disableSaveButton()
        }
        
    }
    
}

extension SettingsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        print(viewModel?.getaddressesCount())
        return viewModel?.getaddressesCount() ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
        
        
        cell.cellAddress = (viewModel?.getCustomerAddress(retrievedIndex: indexPath.row).address) ?? ""

        //print(viewModel?.getCustomerAddress(retrievedIndex: indexPath.row).id)
        
        var add = viewModel?.getCustomerAddress(retrievedIndex: indexPath.row)
        add?.address! = cell.addressTextField.text!
        cell.updateAddress = {
            print("update add button")
            print(add)
            print(cell.addressTextField.text!)
            print(add?.address!)
            self.viewModel?.updateCustomerAddress(address: add!)
        }
        //print("*****************")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    
}