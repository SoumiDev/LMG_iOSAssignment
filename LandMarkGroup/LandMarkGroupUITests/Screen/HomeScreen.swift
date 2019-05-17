//
//  HomeScreen.swift
//  LandMarkGroupUITests
//
//  Created by Dutta, Soumitra on 17/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import Foundation
import XCTest
class HomeScreen {
    
    let app = XCUIApplication()
    let lblHeadline: XCUIElement!
    
    init() {
        //UILabel -- lblHeadline
        lblHeadline = app.staticTexts["Home-LblHeadline"]
    }

   
}
