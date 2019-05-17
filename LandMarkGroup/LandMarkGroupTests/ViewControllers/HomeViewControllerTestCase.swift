//
//  HomeViewControllerTestCase.swift
//  LandMarkGroupTests
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import XCTest
@testable import LandMarkGroup

class HomeViewControllerTestCase: XCTestCase {
    var homeViewController : HomeViewController! = nil
    override func setUp() {
        let storyboard = UIStoryboard(name: ProductConstants.mainStoryboardName, bundle: nil)
        homeViewController = storyboard.instantiateViewController(withIdentifier: ProductConstants.Identifier.homeViewController) as? HomeViewController
        homeViewController.productItemViewModel.isMock = true
    }

    override func tearDown() {
        homeViewController = nil
    }
    
   
    
    // MARK:- Test Cases
    
    func testViewDiLoad() {
        //ARRANGE
        setUpViewControllerToRootViewController()
        
        //ACT
        homeViewController.viewDidLoad()
        
        //ASSERT
        XCTAssertTrue(homeViewController.btnAED.isSelected)
    }
    
    
    
    // MARK: - CollectionView Data Source TestCases

    func testNumberOfRowsInSection0_ShouldBeCount3() {
        //ARRANGE
        setUpViewControllerToRootViewController()
        setUpCollectionViewDataSource()
        homeViewController.productItemViewModel.setupViewModels(productItems: homeViewController.productItemViewModel.productItems)

        
        //ACT
        let rowCount = homeViewController.collectionView(homeViewController.productCollectionView, numberOfItemsInSection: 0)
        
        //ASSERT
        XCTAssertEqual(rowCount, 3, "Incorrect number of rows")
    }
    
    
    func testcellForRowForProductItemCell() {
        //ARRANGE
        setUpCollectionViewDataSource()
        setUpViewControllerToRootViewController()
        homeViewController.productItemViewModel.setupViewModels(productItems: homeViewController.productItemViewModel.productItems)
        let indexPath = IndexPath(row: 0, section: 0)
        
        //ACT
        let cell = homeViewController.collectionView(homeViewController.productCollectionView, cellForItemAt: indexPath) as! ProductListCollectionViewCell
        //ASSERT
        XCTAssertEqual(cell.lblTitle.text , "Test1")
    }
    
    
    
    // MARK: - Helper Methods
    func setUpViewControllerToRootViewController() {
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    func setUpCollectionViewDataSource(){
        let productItemTestData = ProductItemTestData()
        
        homeViewController.productItemViewModel.setUpProductList(arrProducts: productItemTestData.setupProudtDic() as [AnyObject])
        homeViewController.productItemViewModel.setUpCurrencyList(arrCurrency: productItemTestData.setupCurrencyConvDic() as [AnyObject])
        
     //homeViewController.productItemViewModel.setupViewModels(productItems:homeViewController.productItemViewModel.productItems)
    }
    

}
