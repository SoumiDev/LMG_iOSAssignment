//
//  CommonAlertView.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import UIKit
class CommonAlertView {
    
    class func showCommonAlert(viewController: UIViewController, title: String, message: String, OkButtonTitle: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: OkButtonTitle, style: .default) { action in
            
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
    // TODO: Add more custom alert based on error.
    
}
