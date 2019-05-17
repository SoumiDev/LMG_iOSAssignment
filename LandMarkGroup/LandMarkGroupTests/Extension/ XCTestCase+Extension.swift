//
//  XCTestCase+Extension.swift
//  LandMarkGroupTests
//
//  Created by Dutta, Soumitra on 17/05/19.
//  Copyright © 2019 Soumitra. All rights reserved.
//

import Foundation
import XCTest
extension XCTestCase {
    
    func waitForActivityIndicatorToFinishSpinning(_ activityIndicatorElement: XCUIElement, timeout: TimeInterval) {
        let progressHaltedPredicate = NSPredicate(format: "exists == 0")
        self.expectation(for: progressHaltedPredicate, evaluatedWith: activityIndicatorElement, handler: nil)
        self.waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func waitForNavigation(element: XCUIElement, timeout: TimeInterval) {
        let progressHaltedPredicate = NSPredicate(format: "exists == 1")
         expectation(for: progressHaltedPredicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout, handler: nil)
    }
    func wait(element: XCUIElement, timeout: TimeInterval) {
        let progressHaltedPredicate = NSPredicate(format: "exists == 1")
        expectation(for: progressHaltedPredicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
}
