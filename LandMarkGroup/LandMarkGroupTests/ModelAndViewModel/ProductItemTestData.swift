//
//  ProductItemTestData.swift
//  LandMarkGroupTests
//
//  Created by Dutta, Soumitra on 17/05/19.
//  Copyright © 2019 Soumitra. All rights reserved.
//

import Foundation
@testable import LandMarkGroup

class ProductItemTestData {
    
    func setupProudtDic() -> [ResponseDic] {
        
        let dic1 = ["name" : "Test1", "url" : "Test ImageUrl 1", "currency" : "AED", "price" : "500.00"]
        let dic2 = ["name" : "Test2", "url" : "Test ImageUrl 2", "currency" : "SAR", "price" : "100.00"]
        let dic3 = ["name" : "Test3", "url" : "Test ImageUrl 23", "currency" : "INR", "price" : "150.00"]
        let arrDic = [dic1, dic2, dic3]
        return arrDic
    }
    
    func setupCurrencyConvDic() -> [ResponseDic] {
        
        let dic1 = ["from" : "AED", "to" : "SAR", "rate" : "0.8"]
        let dic2 = ["from" : "AED", "to" : "INR", "rate" : "17.1"]
        let dic3 = ["from" : "SAR", "to" : "INR", "rate" : "17.2"]
        let dic4 = ["from" : "INR", "to" : "AED", "rate" : "0.057"]
        let arrDic = [dic1, dic2, dic3, dic4]
        return arrDic
    }
    
    
    
}

