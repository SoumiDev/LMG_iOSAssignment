//
//  ProductItemViewModel.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 16/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import Foundation

class ProductItemViewModel {
    // Constant and Variables
    private let productServiceHelper : ProductServiceHelperProtocol
    lazy var alertMessage : String = ""
    lazy var productItems = [ProductItem]()
    private var currencyConversionArr = [CurrencyData]()
    var showAlert : (() -> ())?
    var showHideLoading : (() -> ())?
    var reloadProductListCollection : (() -> ())?
    var updateUI : (() -> ())?
    var updateLabelTimeLeft : (() -> ())?
    lazy var timerString : String = ""
    var isMock = false
    
    // MARK: - ViewModel And View Binding
    var currencyType = CurrencyType.AED  {
        didSet {
            reloadProductListCollection?()
        }
    }
    private var productItemCellViewModels = [ProductItemCellViewModel]() {
        didSet {
            reloadProductListCollection?()
        }
    }
    
    private var dealOnTimer : DealOnTimer = {
        return DealOnTimer()
    }()
    
    init(productServiceHelper : ProductServiceHelperProtocol = ProductServiceHelper()) {
        self.productServiceHelper = productServiceHelper
    }
    
    var headline : String = "" {
        didSet{
           updateUI?()
        }
    }
    
    
    var isLoading : Bool = false {
        didSet{
            showHideLoading?()
        }
    }
    
    // Timer Setup and Binding
    
    func initDealOnTimer(){
        dealOnTimer.updateTimerlabel = { [weak self] in
            self?.timerString = (self?.dealOnTimer.stringTimer)!
            self?.updateLabelTimeLeft?()
            
        }
        dealOnTimer.convertilisecondsToHhMmSs()
    }
    
    
    
    
    
    // MARK: - Service Request
    func initFetch() {
        if isMock {
            return
        }
        isLoading = true
        productServiceHelper.productServiceRequest(urlString: Websettings.shared.baseURL,
            success: {
              [weak self] response in
              print("Success")
              self?.isLoading = false
              self?.setUpProductListAndCurrencyConversion(response: response)
              self?.initDealOnTimer()
            },
            failure: {
              [weak self] response in
              print("Failed")
              self?.isLoading = false
              self?.alertMessage = "Error"
              self?.showAlert?()
        })
    }
    
    
    
    
    // MARK: - Setup Data From Service Response
    func setUpProductListAndCurrencyConversion(response: ResponseDic){
        if let title = response[ProductConstants.title] {
            headline = title as! String
        }
        //setup currency conversion data
        let arrCurrency = response[ProductConstants.conversion] as? [ResponseDic]
        guard (arrCurrency != nil) else {
            return
        }
        setUpCurrencyList(arrCurrency: arrCurrency! as [AnyObject])
        
        // setup product data
        let arrProducts = response["products"] as? [AnyObject]
        guard (arrProducts != nil) else {
            return
        }
        setUpProductList(arrProducts: arrProducts!)
        
        //setup View Models
        setupViewModels(productItems: productItems)
        
    }
    
    
    
    //MARK: - Setup Model List Data Source
    var  numberOfRows : Int {
        return productItemCellViewModels.count
    }
    
    
    func createProductItemCellViewModel(productItem : ProductItem, index: Int) -> ProductItemCellViewModel {
        return ProductItemCellViewModel(name: productItem.name, imageUrl: productItem.url, cellIndex: IndexPath(row: index, section: 0), price: productItem.price, currency: productItem.currency)
    }
    
}




// MARK: Setup Model And View Model
extension ProductItemViewModel {
    func setupViewModels(productItems: [ProductItem]){
        var viewModels = [ProductItemCellViewModel]()
        for product in productItems {
            viewModels.append(createProductItemCellViewModel(productItem: product, index: viewModels.count))
        }
        productItemCellViewModels = viewModels
    }
    
    func setUpProductList(arrProducts: [AnyObject]){
        if !(arrProducts.isEmpty) {
            productItems.removeAll()
        }
        for object in arrProducts {
            var productItem = ProductItem()
            productItem.name = object[ProductConstants.ProductItem.name] as? String ?? ""
            productItem.url = object[ProductConstants.ProductItem.url] as? String ?? ""
            productItem.currency = object[ProductConstants.ProductItem.currency] as? String ?? ""
            productItem.price = object[ProductConstants.ProductItem.price] as? String ?? ""
            productItems.append(productItem)
            
        }
    }
    func setUpCurrencyList(arrCurrency: [AnyObject]){
        
        if !(arrCurrency.isEmpty) {
            currencyConversionArr.removeAll()
        }
        
        for object in arrCurrency {
            var currencyData = CurrencyData()
            currencyData.from = object[ProductConstants.from] as? String ?? ""
            currencyData.to = object[ProductConstants.to] as? String ?? ""
            currencyData.rate = object[ProductConstants.rate] as? String ?? ""
            currencyConversionArr.append(currencyData)
        }
    }
}




// MARK: - Fetch VieeModel from Date Source
extension ProductItemViewModel{
    func getProductCellViewModel( indexPath : IndexPath) -> ProductItemCellViewModel{
        var productItemCellViewModel = productItemCellViewModels[indexPath.row]
        if productItemCellViewModel.currency == currencyType.rawValue {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:Double(productItemCellViewModel.price!)!))
            productItemCellViewModel.price = currencyType.rawValue + " " + formattedNumber! //+ productItemCellViewModel.price!
            return productItemCellViewModel
        }
        else{
            let currencyRate = getCurrencyRate(from: productItemCellViewModel.currency!, to: currencyType.rawValue)
            let defaultPrice = Double(productItemCellViewModel.price!)
            let currentPrice = Double(currencyRate)! * defaultPrice!
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:currentPrice))
            productItemCellViewModel.price = currencyType.rawValue + " " + formattedNumber! //+ String(format: "%.2f",currentPrice)
            return productItemCellViewModel
        }
    }
    
    
    
    // MARK: - Currency Dependent Rate
    func getCurrencyRate(from: String, to : String) -> String{
        let result = currencyConversionArr.filter { $0.from == from && $0.to == to }
        if !result.isEmpty{
            return result[0].rate!
        }
        else{
            let result1 = currencyConversionArr.filter { $0.to == from && $0.from == to }[0]
            let rate =  Double(result1.rate!)
            let reverseRate = 1 / rate!
            return String(reverseRate)
        }
    }
}



