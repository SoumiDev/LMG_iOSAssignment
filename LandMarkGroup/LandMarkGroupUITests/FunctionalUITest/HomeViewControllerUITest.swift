//
//  HomeViewControllerUITest.swift
//  LandMarkGroupUITests
//
//  Created by Dutta, Soumitra on 17/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import XCTest

class HomeViewControllerUITest: LandMarkGroupUITests {

    var homeVC : HomeScreen!
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMinimumElementLoaded() {
        homeVC = HomeScreen()
        waitForNavigation(element: homeVC.lblHeadline, timeout: 100.0)
        XCTAssertTrue(homeVC.lblHeadline.exists)
    }
    

}
