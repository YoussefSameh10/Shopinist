//
//  CheckoutViewController.swift
//  Shopinist
//
//  Created by Youssef on 6/7/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import UIKit
import Combine

class CheckoutViewController: UIViewController {
    
    var viewModel: CheckoutViewModelProtocol!
    var router: CheckoutRouterProtocol!
    
    var cancellables: Set<AnyCancellable> = []

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalPriceAfterDiscount: UILabel!
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet weak var validatePromoCodeButton: UIButton!
    @IBOutlet weak var cashOnDeliveryButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var textStrokeView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    
    init(
        nibName: String = String(describing: CheckoutViewController.self),
        viewModel: CheckoutViewModelProtocol,
        router: CheckoutRouterProtocol = CheckoutRouter()
    ) {
        super.init(nibName: nibName, bundle: nil)
        self.viewModel = viewModel
        self.router = router
        self.router.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        showNavBar()
        initPriceLabel()
        initButtons()
        initPromoCodeTextField()
        initAddressLabel()
        initTextStrokeView()
        listenForChangesPriceRule()
    }
    
    private func showNavBar() {
        self.title = "Checkout"
        navigationController?.navigationBar.isHidden = false
    }
    
    private func initPriceLabel() {
        totalPriceLabel.text = viewModel.getOrderPrice()
    }
    
    private func initButtons() {
        
        let buttons = [validatePromoCodeButton, cashOnDeliveryButton, placeOrderButton]
        
        for button in buttons {
            drawBlackButton(button)
        }
        drawWhiteButton(applePayButton)
        disableButton(validatePromoCodeButton)
    }
    
    private func initPromoCodeTextField() {
        promoCodeTextField.layer.cornerRadius = 25
        promoCodeTextField.layer.borderWidth = 1.0
        promoCodeTextField.layer.borderColor = UIColor.black.cgColor
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        promoCodeTextField.leftView = paddingView
        promoCodeTextField.leftViewMode = .always
    }
    
    private func initAddressLabel() {
        addressLabel.text = viewModel.order?.shippingAddress?.address ?? ""
    }
    
    private func initTextStrokeView() {
        textStrokeView.transform = CGAffineTransform(rotationAngle: CGFloat(exactly: 20 * Double.pi/180)!);
    }
    
    private func listenForChangesPriceRule() {
        viewModel.isValidPriceRule.sink { (isValid) in
            guard let isValid = isValid else {
                return
            }
            if(!isValid) {
                self.showErrorAlert()
            }
            else {
                self.showPriceAfterDiscount()
            }
        }.store(in: &cancellables)
    }
    
    
    
    @IBAction func promoCodeDidChange(_ sender: Any) {
        if promoCodeTextField.text?.isEmpty ?? true {
            disableButton(validatePromoCodeButton)
        }
        else {
            enableButton(validatePromoCodeButton)
        }
    }
    @IBAction func validatePromoCode(_ sender: Any) {
        viewModel.priceRule = promoCodeTextField.text
        viewModel.validatePromoCode()
    }
    @IBAction func cashOnDeliveryPressed(_ sender: Any) {
        viewModel.isPaymentCash = true
        drawBlackButton(cashOnDeliveryButton)
        drawWhiteButton(applePayButton)
    }
    @IBAction func applePayPressed(_ sender: Any) {
        viewModel.isPaymentCash = false
        drawBlackButton(applePayButton)
        drawWhiteButton(cashOnDeliveryButton)
    }
    @IBAction func placeOrder(_ sender: Any) {
        showPlaceOrderAlert()
    }
}

extension CheckoutViewController {
    private func drawBlackButton(_ button: UIButton?) {
        button?.backgroundColor = .black
        button?.setTitleColor(.white, for: .normal)
        button?.tintColor = .white
        button?.layer.cornerRadius = 25
    }
    
    private func drawWhiteButton(_ button: UIButton?) {
        button?.backgroundColor = .white
        button?.layer.borderWidth = 1
        button?.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        button?.setTitleColor(.black, for: .normal)
        button?.tintColor = .black
        button?.layer.cornerRadius = 25
    }
    
    private func disableButton(_ button: UIButton) {
        button.isEnabled = false
        button.backgroundColor = .white
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderColor = CGColor(srgbRed: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        button.layer.borderWidth = 1
    }
    
    private func enableButton(_ button: UIButton) {
        button.isEnabled = true
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 0
    }
}

extension CheckoutViewController {
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Invalid Promo Code", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func showPriceAfterDiscount() {
        totalPriceLabel.textColor = .gray
        self.totalPriceAfterDiscount.text = String(viewModel.priceAfterDiscount ?? 0)
        self.totalPriceAfterDiscount.isHidden = false
        textStrokeView.isHidden = false
        promoCodeTextField.isEnabled = false
        disableButton(validatePromoCodeButton)
    }
    
    private func showPlaceOrderAlert() {
        let alert = UIAlertController(title: "Place Order", message: "Are you sure you want to place this order?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.viewModel.postOrder()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
