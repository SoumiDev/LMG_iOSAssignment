//
//  WelcomeViewScreen.swift
//  LandMarkGroupUITests
//
//  Created by Dutta, Soumitra on 17/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import Foundation
import XCTest
class WelcomeViewScreen {
    let app = XCUIApplication()
    let vwICon : XCUIElement!
    
    init() {
        vwICon = app.staticTexts["Welcome-VwIcon"]
    }
    
}
