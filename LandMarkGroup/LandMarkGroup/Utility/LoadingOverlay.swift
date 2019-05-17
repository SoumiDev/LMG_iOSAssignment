//
//  LoadingOverlay.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import UIKit

class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    static let shared = LoadingOverlay()
    
    
    public func showOverlay(view: UIView!) {
        DispatchQueue.main.async { [weak self] in
            let window = UIApplication.shared.keyWindow!
            window.isUserInteractionEnabled = false
            self?.overlayView = UIView(frame: UIScreen.main.bounds)
            self?.overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self?.activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
            self?.activityIndicator.center = (self?.overlayView.center)!
            self?.activityIndicator.color = ProductConstants.customColor.customBlue
            self?.overlayView.addSubview((self?.activityIndicator)!)
            self?.activityIndicator.startAnimating()
            self?.activityIndicator.accessibilityIdentifier = ProductConstants.AccessibiltyIdentifier.activityIndicator
            view.addSubview(self!.overlayView)
        }
    }
    
    public func hideOverlayView() {
        DispatchQueue.main.async { [weak self] in
            let window = UIApplication.shared.keyWindow!
            window.isUserInteractionEnabled = true
            self?.activityIndicator.stopAnimating()
            self?.overlayView.removeFromSuperview()
        }
    }
}
