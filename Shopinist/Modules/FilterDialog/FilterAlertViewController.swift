//
//  FilterAlertViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/4/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit

class FilterAlertViewController: UIViewController {
    
    var viewModel: CategoriesFilterViewModelProtocol!
    
    var selectedFilterType = FilterType.NAME {
        didSet {
            switch selectedFilterType {
            case .NAME:
                setButtonActivated(button: nameButton)
                setButtonInActivated(button: priceButton)
            case .PRICE:
                setButtonActivated(button: priceButton)
                setButtonInActivated(button: nameButton)
            }
        }
    }
    
    var selectedFilterDirection = FilterDirection.ASCENDING {
        didSet {
            switch selectedFilterDirection {
            case .ASCENDING:
                setButtonActivated(button: ascendingButton)
                setButtonInActivated(button: descendingButton)
            case .DESCENDING:
                setButtonActivated(button: descendingButton)
                setButtonInActivated(button: ascendingButton)
            }
        }
    }
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var priceSlider: UISlider!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var nameButton: UIButton!
    @IBOutlet private weak var priceButton: UIButton!
    @IBOutlet private weak var ascendingButton: UIButton!
    @IBOutlet private weak var descendingButton: UIButton!
    @IBOutlet private weak var submitButton: UIButton!
    
    
    init(nibName: String?, viewModel: CategoriesFilterViewModelProtocol) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerView()
        setupPriceSlider()
        setupPriceLabel()
        setupFilterButtons()
        setupSubmitButton()
    }

    private func setupContainerView() {
        containerView.layer.cornerRadius = 25
    }
    
    private func setupPriceSlider() {
        priceSlider.minimumValue = 0
        priceSlider.maximumValue = 1000
        priceSlider.value = Float(viewModel.maxPrice)
    }
    
    private func setupPriceLabel() {
        priceLabel.text = "\(viewModel.maxPrice)"
    }
    
    private func setupFilterButtons() {
        let buttons = [nameButton, priceButton, ascendingButton, descendingButton]
        
        var activeButtons: [UIButton] = []
        var inActiveButtons: [UIButton] = []
        
        classifyButtons(&activeButtons, &inActiveButtons)
        
        
        
        for button in buttons {
            button?.layer.borderWidth = 1
            button?.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
            button?.layer.cornerRadius = 10
        }
        
        for button in activeButtons {
            setButtonActivated(button: button)
        }
        
        for button in inActiveButtons {
            setButtonInActivated(button: button)
        }
    }
    
    private func classifyButtons(_ activeButtons: inout [UIButton], _ inActiveButtons: inout [UIButton]) {
        if(viewModel.filterType == .NAME) {
            activeButtons.append(nameButton)
            inActiveButtons.append(priceButton)
        }
        else {
            activeButtons.append(priceButton)
            inActiveButtons.append(nameButton)
        }
        
        if(viewModel.filterDirection == .ASCENDING) {
            activeButtons.append(ascendingButton)
            inActiveButtons.append(descendingButton)
        }
        else {
            activeButtons.append(descendingButton)
            inActiveButtons.append(ascendingButton)
        }
    }
    
    private func setButtonActivated(button: UIButton?) {
        button?.backgroundColor = .black
        button?.setTitleColor(.white, for: .normal)
    }
    
    private func setButtonInActivated(button: UIButton?) {
        button?.backgroundColor = .white
        button?.setTitleColor(.black, for: .normal)
    }
    
    private func setupSubmitButton() {
        submitButton.layer.cornerRadius = 10
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        submitButton.setTitleColor(.black, for: .normal)
    }
    
    
    @IBAction func priceSliderDidChange(_ sender: Any) {
        priceLabel.text = "\(Int(priceSlider.value))"
    }
    
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedFilterType = .NAME
        case 1:
            selectedFilterType = .PRICE
        case 2:
            selectedFilterDirection = .ASCENDING
        case 3:
            selectedFilterDirection = .DESCENDING
        default:
            selectedFilterDirection = .ASCENDING
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        viewModel.filterType = selectedFilterType
        viewModel.filterDirection = selectedFilterDirection
        viewModel.maxPrice = Int(priceSlider.value)
        viewModel.filterProducts()
        self.dismiss(animated: true, completion: nil)
    }
    
}
