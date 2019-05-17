//
//  ProductConstants.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//


import UIKit

struct ProductConstants {
    
    static let mainStoryboardName = "Main"
    static let launchScreenName = "LaunchScreen"
    
    struct Identifier {
        static let welcomeViewController = "WelcomeVC"
        static let homeViewController = "HomeVC"
    }
    
    struct ImageName {
        static let noImage = "NoImage"
        static let no_Image = "No_Image"
    }
    
    static let title = "title"
    static let products = "products"
    static let to = "to"
    static let from = "from"
    static let rate = "rate"
    static let conversion = "conversion"
    
    struct ProductItem {
        static let name = "name"
        static let url = "url"
        static let currency = "currency"
        static let price = "price"
    }
    
    static let error = "Error"
    static let projectName = "LandMark Group"
    static let home = "Home"
    static let networkNotAvailable = "Network not available.Please check your internet connection."
    static let noInternetConnection = "No internet connection available. Pease try again later."
    static let  okAlertTitle = "OK"
    static let arrayDownLoadingQueue = "ArrayDownLoadingQueue"
    static let productImageDownload = "ProductImageDownload"
    static let serviceUnavailable = "Service is currently unavailable. Please try agagin later."
    static let welcomScreenTitle = "Ladmark Group"
    
    // TODO : Setup AccessibiltyIdentifier Name for UI Test
    struct AccessibiltyIdentifier {
        static let activityIndicator = "Loading-View"
    }
    
    struct customColor {
       static let customBlue = UIColor(red: 24/255.0, green: 146/255.0, blue: 213/255.0, alpha: 1.0)
        // TODO: Use Hex String Instead of RGB
    }
    
    static let endTimeMilicseconds : Double = 15952752  //1595275200000
}
