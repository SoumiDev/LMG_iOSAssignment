//
//  NetworkMonitoringManager.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import UIKit
class NetworkMonitoringManager {
    static let shared = NetworkMonitoringManager()
    let reachability = Reachability()!
    var isConnectionAvailable = false
    
    
    func setUpNetworkMonitoring(){
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    func isReachable() -> Bool{
        if (self.reachability.connection != .none){
            return true
        }
        else{
            return false
        }
    }
    
    func isUnreachable() -> Bool {
        if (self.reachability.connection == .none){
            return true
        }
        else{
            return false
        }
    }
    
    func isReachableViaWWAN() -> Bool{
        if (self.reachability.connection == .cellular){
            
            return true
        }
        else{
            
            return false
        }
    }
    
    func isReachableViaWiFi() ->Bool{
        if (self.reachability.connection == .wifi){
            
            return true
        }
        else{
            
            return false
        }
    }
    
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        self.isConnectionAvailable = reachability.connection != .none
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            checkProductStatus()
        case .cellular:
            print("Reachable via Cellular")
            checkProductStatus()
        case .none: do {
            print("Network not reachable")
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            CommonAlertView.showCommonAlert(viewController: (appdelegate.window?.rootViewController)!, title: ProductConstants.projectName, message: ProductConstants.noInternetConnection, OkButtonTitle: ProductConstants.okAlertTitle)
            }
        }
    }
}


extension NetworkMonitoringManager {
    
    func checkProductStatus(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let currentVC =  appdelegate.navigationController?.visibleViewController
        if currentVC is WelcomeViewController {
            let  vc = currentVC as! WelcomeViewController
            vc.preParePushToHomeView()
        }
        else if currentVC is HomeViewController {
           let  vc = currentVC as! HomeViewController
            if vc.productItemViewModel.numberOfRows == 0 {
                vc.productItemViewModel.initFetch()
            }
        }
    }
}
