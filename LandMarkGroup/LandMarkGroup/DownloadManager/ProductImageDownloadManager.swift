//
//  ProductImageDownloadManager.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//


import UIKit
class ProductImageDownloadManager {
    
    static let shared = ProductImageDownloadManager()
    var task: URLSessionDownloadTask!
    var session: URLSession!
    lazy var cache:NSCache<AnyObject, AnyObject>! = NSCache()
    var arrDownloading = [String]()
    let serialQueue = DispatchQueue(label: ProductConstants.arrayDownLoadingQueue)

    
    // MARK:- SetUp Product Image Download

    func setUpProductImage(imageView: UIImageView,collectionView: UICollectionView, indexPath : NSIndexPath, urlString : String){
        let keyIndex = urlString
        if (self.cache.object(forKey: keyIndex as AnyObject) != nil){
            //Cached image used, no need to download it.
                imageView.image = cache.object(forKey: keyIndex as AnyObject) as? UIImage
        }
        else if arrDownloading.contains(keyIndex) {
            //Current Image is downloading. Wait to get image downloaded.
            print("Current Image is downloading. Wait to get image downloaded.")
            return
        }
        else if NetworkMonitoringManager.shared.isConnectionAvailable {
            // Download Image
            initiateProductImageDownloading(collectionView: collectionView, indexPath: indexPath, urlString: urlString)
        }
    }
    

    
    // MARK:- Start Product Image Download

    private func initiateProductImageDownloading(collectionView: UICollectionView, indexPath : NSIndexPath, urlString : String) {
        let keyIndex = urlString
        let dispatchQueue = DispatchQueue(label: ProductConstants.productImageDownload + keyIndex)
        //Perform task in a background thread
        dispatchQueue.async { [weak self] in
            if let url = URL(string: urlString) {
                // Track Key reference of image downloading
                self?.updateDownLoadingContains(shouldAdd: true, keyIndex: keyIndex)
                //Create URL Request
                print(url)
                let request: URLRequest = URLRequest(url: url)
                // Create Session Configuration
                let sessionConfig = URLSessionConfiguration.default
                // SetUp Session Configuration
                sessionConfig.timeoutIntervalForRequest = Websettings.shared.requestTimeOut
                sessionConfig.timeoutIntervalForResource = Websettings.shared.requestTimeOut
                // Create Session
                let session = URLSession(configuration: sessionConfig)
                //Create Task
                let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                    // Task Completed
                    let error = error
                    let data = data
                    if error == nil {
                        // Download Completed. Remove key reference from Array
                        self?.updateDownLoadingContains(shouldAdd: false, keyIndex: keyIndex)
                        // Convert the downloaded data in to a UIImage object
                        if let image = UIImage(data: data!) {
                        // Store the image into cache
                        self!.cache.setObject(image, forKey: keyIndex as AnyObject)
                        // Update the cell content
                            DispatchQueue.main.async{
                                collectionView.reloadItems(at: [indexPath as IndexPath])
                        }
                      }
                        else {
                            self?.updateDownLoadingContains(shouldAdd: false, keyIndex: keyIndex)

                        }
                    }
                    else {
                        // Download Failed. Remove key reference from Array to redownload image.
                        self?.updateDownLoadingContains(shouldAdd: false, keyIndex: keyIndex)

                    }
                })
                // Execute Task
                task.resume()
            }
            
        }
        
    }
    
    

    
}



extension ProductImageDownloadManager {
    
    // MARK:- Add/Remove Array Downloading contains
    private func updateDownLoadingContains(shouldAdd: Bool, keyIndex : String){
        serialQueue.sync {
            if shouldAdd {
                arrDownloading.append(keyIndex)
            }
            else {
                if let index = arrDownloading.index(of: keyIndex) {
                    arrDownloading.remove(at: index)
                }
            }
            
        }
    }
    // MARK:- Dispose Cache
    func clearCache() {
        URLCache.shared.removeAllCachedResponses()
        cache.removeAllObjects()
    }
}


