//
//  CategoriesViewControllerTests.swift
//  ShopinistTests
//
//  Created by Youssef on 6/24/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import XCTest
@testable import Shopinist

class CategoriesViewControllerTests: XCTestCase {

    var sut = CategoriesViewController(viewModel: CategoriesViewModelStub(
        productRepo: ProductRepoStub(), category: .Men
    ))
    
    func testSut_whenViewControllerLoaded_titleMatchesCategory() {
        sut.loadViewIfNeeded()
        sut.viewWillLayoutSubviews()
        XCTAssert(sut.title == "Men")
        
    }
    
    func testSut_whenViewControllerLoaded_activityIndicatorStarts() {
        sut.loadViewIfNeeded()
        XCTAssert(sut.indicator.isAnimating == false)
    }
    
    func testSut_whenViewControllerLoaded_searchControllerIsSet() {
        sut.loadViewIfNeeded()
        XCTAssert(sut.navigationItem.searchController != nil)
    }
    
    func testSut_whenViewControllerLoaded_collectionViewIsEmpty() {
        sut.loadViewIfNeeded()
        XCTAssert(sut.collectionView(sut.collectionView, numberOfItemsInSection: 0) == 0)
    }
    
    func testSut_whenViewControllerLoaded_searchBarIsEmpty() {
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.isSearchBarEmpty)
    }

}
