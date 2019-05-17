//
//  WelcomeViewControllerTestCase.swift
//  LandMarkGroupTests
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import XCTest
@testable import LandMarkGroup

class WelcomeViewControllerTestCase: XCTestCase {
    var welcomeVC : WelcomeViewController! = nil
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: ProductConstants.mainStoryboardName, bundle: nil)
        welcomeVC = storyboard.instantiateViewController(withIdentifier: ProductConstants.Identifier.welcomeViewController) as? WelcomeViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        welcomeVC = nil
    }
    
    // MARK:- Test Cases
    
    func testViewDiLoad() {
        
        //ARRANGE
        setUpViewControllerToRootViewController()
        
        //ACT
        welcomeVC.viewDidLoad()
        
        //ASSERT
        XCTAssertEqual(welcomeVC.isPushedToHome, true)
    }
    
    func testAnimation() {
        
        //ARRANGE
        setUpViewControllerToRootViewController()
        
        //ACT
        welcomeVC.initAnimation()
        
        //ASSERT
        XCTAssertEqual(welcomeVC.vwIcon.alpha, 1.0)
    }
    
    func testNavigateToHomeVC()  {
        //ARRANGE
        let navigationController = UINavigationController(rootViewController: welcomeVC)
        UIApplication.shared.keyWindow?.rootViewController = navigationController

        //ACT
        welcomeVC.pushToHomeView()
        
        //ASSERT
        XCTAssertTrue(navigationController.visibleViewController is HomeViewController)
    }
    
    // MARK: - Helper Methods
    func setUpViewControllerToRootViewController() {
        UIApplication.shared.keyWindow?.rootViewController = welcomeVC
    }

}
