//
//  WelcomeViewControllerUITest.swift
//  LandMarkGroupUITests
//
//  Created by Dutta, Soumitra on 17/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import XCTest

class WelcomeViewControllerUITest: LandMarkGroupUITests {

    var welcomeScreen : WelcomeViewScreen!
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        welcomeScreen = nil
    }
    
    func testMinimumElementLoaded() {
        welcomeScreen = WelcomeViewScreen()
        XCTAssertTrue(welcomeScreen.vwICon.exists)
    }

}
