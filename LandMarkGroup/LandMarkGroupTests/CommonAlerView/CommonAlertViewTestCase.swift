//
//  CommonAlertViewTestCase.swift
//  LandMarkGroupTests
//
//  Created by Dutta, Soumitra on 17/05/19.
//  Copyright © 2019 Soumitra. All rights reserved.
//

import XCTest
@testable import LandMarkGroup

class CommonAlertViewTestCase: XCTestCase {

    var vc: WelcomeViewController!
    override func setUp() {
        let storyboard = UIStoryboard(name: ProductConstants.mainStoryboardName, bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: ProductConstants.Identifier.welcomeViewController) as? WelcomeViewController
    }

    override func tearDown() {
        vc = nil
    }

    // MARK : - Test Cases
    func testAlert() {
        
        //ARRANGE
        setUpViewControllerToRootViewController()
        
        //ACT
        CommonAlertView.showCommonAlert(viewController: vc, title: ProductConstants.projectName, message: ProductConstants.networkNotAvailable, OkButtonTitle: ProductConstants.okAlertTitle)
        
        // ASSERT
        XCTAssertTrue(vc.presentedViewController is UIAlertController)
        XCTAssertEqual(vc.presentedViewController?.title, ProductConstants.projectName)
    }
    
    // MARK: - Helper Methods
    func setUpViewControllerToRootViewController() {
        UIApplication.shared.keyWindow?.rootViewController = vc
    }

}
