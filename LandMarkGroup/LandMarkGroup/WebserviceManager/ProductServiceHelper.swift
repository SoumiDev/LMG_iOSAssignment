//
//  ProductServiceHelper.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import Foundation

typealias ResponseDic = [String : Any]

protocol ProductServiceHelperProtocol {
    func productServiceRequest(urlString : String, success: @escaping (_ result: ResponseDic) -> Void, failure : @escaping (_ result: ResponseDic) -> Void)
}
class ProductServiceHelper: ProductServiceHelperProtocol {
    
    func productServiceRequest(urlString : String, success: @escaping (_ result: ResponseDic) -> Void, failure : @escaping (_ result: ResponseDic) -> Void)
    {
        guard let url = URL(string: urlString) else {
            return
        }
        // SetUp URL Session
        let sessionConfig = URLSessionConfiguration.default
        // Configure Session
        sessionConfig.timeoutIntervalForRequest = Websettings.shared.requestTimeOut
        sessionConfig.timeoutIntervalForResource = Websettings.shared.requestTimeOut
        let session = URLSession(configuration: sessionConfig)
        // Create Session Task
        let task =  session.dataTask(with: url, completionHandler:{data, response, error -> Void in
            // Task Completed
            if error != nil {
                // Error is Response
                var errorResponse = ResponseDic()
                errorResponse[ProductConstants.error] = ProductConstants.error
                failure(errorResponse)
            }
            if data == nil
            {
                // Error is Response Data
                var errorResponse = ResponseDic()
                errorResponse[ProductConstants.error] = ProductConstants.error
                failure(errorResponse)
            }
            else
            {
                if  let utf8Text = String(data: data! , encoding: .utf8) {
                    // Successful Response
                    success(self.convertStringToDictionary(text: utf8Text))
                }
                else
                {
                    // Error is Response Data
                    var errorResponse = ResponseDic()
                    errorResponse[ProductConstants.error] = ProductConstants.error
                    failure(errorResponse)
                }
            }
        })
        // Execute Session Task
        task.resume()
}
    
}



private extension ProductServiceHelper {
    
    func convertStringToDictionary(text: String) -> ResponseDic {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let dic =  try JSONSerialization.jsonObject(with: data, options: [])
                return dic as! ResponseDic
                
            } catch let error as NSError {
                var errorResponse = ResponseDic()
                errorResponse[ProductConstants.error] = ProductConstants.error
                print(error)
                return errorResponse
            }
        }
        var errorResponse = ResponseDic()
        errorResponse[ProductConstants.error] = ProductConstants.error
        return errorResponse
    }
}
