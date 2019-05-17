//
//  WelcomeViewController.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var vwIcon: UIView!
    var isPushedToHome = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        initAnimation()
    }

    // MARK:- View Animation
    func initAnimation(){
        // Fade out to set the text
        self.vwIcon.alpha = 0.0
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.vwIcon.alpha = 1.0
                self.preParePushToHomeView()
        }, completion: nil)
    }
    
    // MARK:- Navigation
    func preParePushToHomeView(){
        //Check Networko Available
        if NetworkMonitoringManager.shared.isConnectionAvailable && !isPushedToHome{
            self.isPushedToHome = true
            let deadlineTime = DispatchTime.now() + .seconds(4)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
             self?.pushToHomeView()
            }
        }
    }
    
    func pushToHomeView(){
        let storyboard = UIStoryboard(name: ProductConstants.mainStoryboardName, bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: ProductConstants.Identifier.homeViewController) as! HomeViewController
        navigationController?.pushViewController(homeViewController, animated: false)
    }
        
}





