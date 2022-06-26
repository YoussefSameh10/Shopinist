//
//  CartViewControllerTests.swift
//  ShopinistTests
//
//  Created by Mohammad Amr on 6/26/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import XCTest
@testable import Shopinist

class CartViewModelTests: XCTestCase {

    private var sut : CartViewModelProtocol!
    private var cartMgr : CartItemsManagerProtocol!
    
    private var item : CartProduct!
    
    override func setUp() {
        sut = CartViewModel(cartRepo: CartItemsRepo.getInstance(cartItemsManager: CartItemsManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate)))
        
        cartMgr = CartItemsManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate)
        UserDefaults.standard.setValue("test@email.com", forKey: EMAIL)
        
    }

    override func tearDown() {
        UserDefaults.standard.setValue("", forKey: EMAIL)
    }
    
    func testSut_whenGetCartItemsCalledAndDbEmpty_returnEmptyArr() {
        UserDefaults.standard.setValue("", forKey: EMAIL)
        XCTAssertNotNil(sut.getCartItems())
    }

    
    func testSut_whenGetCartItemsCalledAndDbNotEmpty_returnNotNil() {
        XCTAssertNotNil(sut.getCartItems())
    }
    
    
    func testSut_whenGetCartItemsCalledAndDbNotEmpty_returnNotZero() {
        let cnt = sut.getCartItemsCount()
        XCTAssertNotEqual(cnt, 0)
    }
    
    func testSut_whenGetItemAtCalled_returnNotNil() {
        let item = sut.getItemAt(index:0)
        XCTAssertNotNil(item)
    }
    
    func testSut_whenIncrementItemAtCalled_itemCountIncrease() {
        let item = sut.getItemAt(index:0)
        let cntBefore = item!.count
        sut.incrementItemAt(index: 0)
        let cntAfter = item!.count
        XCTAssertEqual(cntBefore + 1, cntAfter)
    }
    
    func testSut_whenDecrementItemAtCalled_itemCountDecrease() {
        let item = sut.getItemAt(index:0)
        let cntBefore = item!.count
        sut.decrementItemAt(index: 0)
        let cntAfter = item!.count
        XCTAssertEqual(cntBefore - 1, cntAfter)
    }
    
    func testSut_whenRemoveItemAt_itemsCountDecreas() {
        let cntBefore = sut.getCartItemsCount()
        sut.removeItemAt(index: cntBefore - 1)
        let cntAfter = sut.getCartItemsCount()
        XCTAssertEqual(cntBefore - 1, cntAfter)
    }
    
    func testSut_whenGetTotalPrice_returnNotZero() {
        let total = sut.getTotalPrice()
        XCTAssertNotEqual(total, 0)
    }
    
}

